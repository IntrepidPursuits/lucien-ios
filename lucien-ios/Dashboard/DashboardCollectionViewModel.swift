//
//  DashboardCollectionViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

class DashboardCollectionViewModel {

    private var lendedComics = DashboardViewModel.dashboardData?.lending
    private var borrowedComics = DashboardViewModel.dashboardData?.borrowing

    func getComicCount() -> Int {
        guard let count = lendedComics?.count else { return 0 }
        return count
    }

    func comicTitle(forIndex index: Int) -> String {
        return lendedComics![index].comicTitle
    }

    func comicDueDate(forIndex index: Int) -> Date {
        guard let returnDate = lendedComics![index].returnDate else { return Date()}
        return returnDate
    }

    func comicBorrower(forIndex index: Int) -> String {
        let firstName = lendedComics![index].borrower?.firstName ?? ""
        let lastName = lendedComics![index].borrower?.lastName ?? ""
        return firstName + " " + lastName
    }

    func comicImageURL(forIndex index: Int) -> String {
        guard let url = lendedComics![index].comicPhotoURL else { return "https://www.petsworld.in/blog/wp-content/uploads/2014/09/adorable-cat.jpg" }
        return url
    }
}
