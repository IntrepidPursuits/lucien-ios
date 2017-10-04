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


    func getCurrentUser(completion: @escaping () -> Void) {
        lucienAPIClient.getCurrentUser { response in
            switch response {
            case .success(let user):
                print("getCurrentUser")
                self.currentUser = user
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func authenticateUser(code: String, completion: @escaping () -> Void) {
        lucienAPIClient.authenticateUser(code: code) { response in
            switch response {
            case .success(let authenticationResponse):
                print("authenticateUser")
                LucienRequest.authorizationHeader = "Bearer " + authenticationResponse.token
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func getDashboard() {
        print(LucienRequest.authorizationHeader)
        print("just entered viewmodel getDashboard")
        lucienAPIClient.getDashboard { response in
            print("In viewmodel dashboard")
            switch response {
            case .success(let result):
                print("getDashboard")
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }

}
