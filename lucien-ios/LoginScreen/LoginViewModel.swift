//
//  LoginManager.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

final class LoginViewModel {

    let lucienAPIClient = LucienAPIClient()
    var currentUser: User?
    var hasCollection: Bool = false

    func getCurrentUser(completion: @escaping () -> Void) {
        lucienAPIClient.getCurrentUser { response in
            switch response {
            case .success(let user):
                self.currentUser = user
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }

    func authenticateUser(code: String, completion: @escaping () -> Void) {
        lucienAPIClient.authenticateUser(code: code) { response in
            switch response {
            case .success(let authenticationResponse):
                LucienRequest.authorizationHeader = "Bearer " + authenticationResponse.token
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }

    func hasCollection(completion: @escaping (Bool) -> Void) {
        lucienAPIClient.hasCollection { response in
            switch response {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
