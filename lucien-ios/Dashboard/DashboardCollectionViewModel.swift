//
//  DashboardCollectionViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

final class DashboardCollectionViewModel {

    private let dashboardComics: [DashboardComicUser]

    init(comics: [DashboardComicUser]) {
        dashboardComics = comics
    }

    func getComicCount() -> Int {
        return dashboardComics.count
    }

    func getUserTypeText(forIndex index: Int) -> String {
        let userType = dashboardComics[index].dashboardUserType
        switch userType {
        case .borrower:
            return "LENT TO"
        case .owner:
            return "BORROWED FROM"
        case .none:
            return ""
        }
    }

    func getComicTitle(forIndex index: Int) -> String {
        return dashboardComics[index].dashboardComic.comicTitle
    }

    func getStoryTitle(forIndex index: Int) -> String {
        return dashboardComics[index].dashboardComic.storyTitle
    }

    func getIssueNumber(forIndex index: Int) -> String {
        guard let issue = dashboardComics[index].dashboardComic.issueNumber else { return "" }
        return issue
    }

    func getVolume(forIndex index: Int) -> String {
        guard let volume = dashboardComics[index].dashboardComic.volume else { return "" }
        return volume
    }

    func getComicDueDate(forIndex index: Int) -> Date {
        guard let returnDate = dashboardComics[index].dashboardComic.returnDate else { return Date()}
        return returnDate
    }

    func comicPerson(forIndex index: Int) -> String {
        let firstName = dashboardComics[index].dashboardUser.firstName
        let lastName = dashboardComics[index].dashboardUser.lastName
        return firstName + " " + lastName
    }

    func comicImageURL(forIndex index: Int) -> String {
        guard let url = dashboardComics[index].dashboardComic.comicPhotoURL else { return "" }
        return url
    }
}
