//
//  DashboardCollectionViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import RxSwift

class DashboardCollectionViewModel {

    private var lendedComics = DashboardViewModel.dashboardData?.lending
    private var borrowedComics = DashboardViewModel.dashboardData?.borrowing
    var collectionViewType: String?

    var comicsInPosession: [Comic]? {
        if collectionViewType == "lending" {
            return lendedComics
        } else if collectionViewType == "borrowing" {
            return borrowedComics
        } else {
            return nil
        }
    }

    func getComicCount() -> Int {
        guard let count = comicsInPosession?.count else { return 0 }
        return count
    }

    func comicTitle(forIndex index: Int) -> String {
        return comicsInPosession![index].comicTitle
    }

    func comicDueDate(forIndex index: Int) -> Date {
        guard let returnDate = comicsInPosession![index].returnDate else { return Date()}
        return returnDate
    }

    func comicBorrower(forIndex index: Int) -> String {
        let firstName = comicsInPosession![index].borrower?.firstName ?? ""
        let lastName = comicsInPosession![index].borrower?.lastName ?? ""
        return firstName + " " + lastName
    }

    func comicOwner(forIndex index: Int) -> String {
        let firstName = borrowedComics![index].owner?.firstName ?? ""
        let lastName = borrowedComics![index].owner?.lastName ?? ""
        return firstName + " " + lastName
    }

    func comicImageURL(forIndex index: Int) -> String {
        guard let url = comicsInPosession![index].comicPhotoURL else { return "https://www.petsworld.in/blog/wp-content/uploads/2014/09/adorable-cat.jpg" }
        return url
    }
}
