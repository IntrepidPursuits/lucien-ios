//
//  DashboardCollectionViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import RxSwift

final class DashboardCollectionViewModel {

//    var viewModel: DashboardViewModel
    var collectionViewType: String?

//    init(dashboardViewModel: DashboardViewModel) {
//        viewModel = dashboardViewModel
//    }

    var comicsInPosession: [Comic]? {
        if collectionViewType == "lending" {
//            return viewModel.getDashboardData?.lendingComics
            return DashboardViewModel.dashboardData?.lendingComics
        } else if collectionViewType == "borrowing" {
//            return viewModel.getDashboardData?.borrowingComics
            return DashboardViewModel.dashboardData?.borrowingComics

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
        let firstName = comicsInPosession![index].owner?.firstName ?? ""
        let lastName = comicsInPosession![index].owner?.lastName ?? ""
        return firstName + " " + lastName
    }

    func comicImageURL(forIndex index: Int) -> String {
        guard let url = comicsInPosession![index].comicPhotoURL else { return "https://www.petsworld.in/blog/wp-content/uploads/2014/09/adorable-cat.jpg" }
        return url
    }
}
