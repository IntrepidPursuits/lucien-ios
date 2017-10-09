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
    var dashboardData: Dashboard?


    func getCurrentUser(completion: @escaping () -> Void) {
        lucienAPIClient.getCurrentUser { response in
            switch response {
            case .success(let user):
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
                LucienRequest.authorizationHeader = "Bearer " + authenticationResponse.token
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

    func getDashboard(completion: @escaping () -> Void) {
        print(LucienRequest.authorizationHeader)
        lucienAPIClient.getDashboard { response in
            switch response {
            case .success(let result):
                self.dashboardData = result
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }

}
