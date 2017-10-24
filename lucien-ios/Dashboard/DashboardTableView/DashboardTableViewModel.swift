//
//  DashboardTableViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/24/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

final class DashboardTableViewModel {

    private let dashboardComics: [DashboardComicUser]

    init(comics: [DashboardComicUser]) {
        dashboardComics = comics
    }

    func getComicCount() -> Int {
        return dashboardComics.count
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

    func comicImageURL(forIndex index: Int) -> String {
        guard let url = dashboardComics[index].dashboardComic.comicPhotoURL else { return "" }
        return url
    }
}

