//
//  LucienAPIClient.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

enum LucienAPIError: Error {
    case noResult
    case cannotDecode
}

final class LucienAPIClient: APIClient {

    func authenticateUser(code: String, completion: @escaping (Result<AuthenticationResponse>) -> Void) {
        let lucienRequest = LucienRequest.authenticate(code: code)
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                let decoder = JSONDecoder()
                let json = try? JSONSerialization.jsonObject(with: result, options: [])
                guard let authenticationResponse = try? decoder.decode(AuthenticationResponse.self, from: result) else { return }
                completion(.success(authenticationResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCurrentUser(completion: @escaping (Result<User>) -> Void) {
        let lucienRequest = LucienRequest.getCurrentUser()
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let user = try decoder.decode(User.self, from: result)
                    completion(.success(user))

                } catch(let error) {
                    print(error)
                    completion(.failure(error))
                }
//                guard let user = try? decoder.decode(User.self, from: result) else {
//                    return
//                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getDashboard(completion: @escaping (Result<Dashboard>) -> Void) {
        let lucienRequest = LucienRequest.getDashboard()
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            print("in LucienAPIClient getDashboard")
            print(response)
            switch response {
            case .success(let result):
                guard let result = result else { return }
                let decoder = JSONDecoder()
                guard let myCollection = try? decoder.decode(Dashboard.self, from: result) else { return }
                completion(.success(myCollection))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
