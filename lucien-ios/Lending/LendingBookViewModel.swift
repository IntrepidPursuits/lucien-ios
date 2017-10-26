//
//  LendingBookViewModel.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/23/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import RxSwift

class LendingBookViewModel {

    var users: Variable<[User]> = Variable([])

    // MARK: - Private Constants

    private let lucienAPIClient = LucienAPIClient()

    func getAllUsers(completion: @escaping ([User]?, Error?) -> Void) {
        lucienAPIClient.getAllUsers { response in
            switch response {
            case .success(let users):
                self.users.value = users
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func lendComic(comicID: String, comic: LentComic, completion: @escaping (Error?) -> Void) {
        lucienAPIClient.lendComic(comicID: comicID, comic: comic) { response in
            switch response {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
