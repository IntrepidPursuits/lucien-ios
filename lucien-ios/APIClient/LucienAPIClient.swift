//
//  LucienAPIClient.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

class LucienAPIClient: APIClient {

    func authenticateUser(code: String) {
        let lucienRequest = LucienRequest.authenticate(code: code)
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            print(response)
        }
    }

    func getCurrentUser(completion: @escaping (Result<Any>) -> Void) {
        let lucienRequest = LucienRequest.getCurrentUser()
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let json = try? JSONSerialization.jsonObject(with: result!, options: []) else { return }
                completion(.success(json))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
