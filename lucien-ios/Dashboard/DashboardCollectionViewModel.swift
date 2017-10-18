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

    var dashboardComics: [DashboardComic]

    init(comics: [DashboardComic]) {
        dashboardComics = comics
    }

    func getComicCount() -> Int {
        return dashboardComics.count
    }

    func comicTitle(forIndex index: Int) -> String {
        return dashboardComics[index].dashboardComic.comicTitle
    }

    func comicDueDate(forIndex index: Int) -> Date {
        guard let returnDate = dashboardComics[index].dashboardComic.returnDate else { return Date()}
        return returnDate
    }

    func comicPerson(forIndex index: Int) -> String {
        let firstName = dashboardComics[index].dashboardUser.firstName
        let lastName = dashboardComics[index].dashboardUser.lastName
        return firstName + " " + lastName
    }

    func comicImageURL(forIndex index: Int) -> String {
        guard let url = dashboardComics[index].dashboardComic.comicPhotoURL else { return "https://www.petsworld.in/blog/wp-content/uploads/2014/09/adorable-cat.jpg" }
        return url
    }
}
