//
//  LucienAPIClient.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

enum LucienAPIError: Error {
    case requestError(request: URLRequest, message: String)
    case responseError(response: Result<Data>, message: String)
    case decodeError(from: Data, to: Decodable, message: String)
    case convertToDataType(data: Result<Data?>, message: String)
}

final class LucienAPIClient: APIClient {

    func authenticateUser(code: String, completion: @escaping (Result<User>) -> Void) {
        let lucienRequest = LucienRequest.authenticate(code: code)
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else { return }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let user = try? decoder.decode(User.self, from: result) else { return }
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCurrentUser(completion: @escaping (Result<User>) -> Void) {
        let lucienRequest = LucienRequest.getCurrentUser
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else { return }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let user = try? decoder.decode(User.self, from: result) else { return }
                completion(.success(user))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
