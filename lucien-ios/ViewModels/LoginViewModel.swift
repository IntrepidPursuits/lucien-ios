//
//  LoginManager.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

final class LoginViewModel {

    let lucienAPIClient = LucienAPIClient()

    func getCurrentUser() {
        lucienAPIClient.getCurrentUser { response in
            switch response {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error)
            }
        }
    }
}
