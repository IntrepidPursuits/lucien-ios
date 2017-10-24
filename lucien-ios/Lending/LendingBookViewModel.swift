//
//  LendingBookViewModel.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/23/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LendingBookViewModel {

    var users: Variable<[User]> = Variable([])

    // MARK: - Private Constants

    private let disposeBag = DisposeBag()
    private let lucienAPIClient = LucienAPIClient()

    func getAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        lucienAPIClient.getAllUsers { response in
            switch response {
            case .success(let users):
                completion(users, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
