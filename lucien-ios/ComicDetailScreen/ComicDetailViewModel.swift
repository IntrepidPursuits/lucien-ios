//
//  ComicDetailViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/24/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class ComicDetailViewModel {

    private let dashboardComicUser: DashboardComicUser

    let emptyDefault = "-"
    let userType: DashboardComicUser.UserType

    let comicImage = Variable(UIImage())
    lazy var comicTitle = Variable(emptyDefault)
    lazy var storyTitle = Variable(emptyDefault)
    lazy var volume = Variable(emptyDefault)
    lazy var issue = Variable(emptyDefault)
    lazy var releaseDate = Variable(emptyDefault)
    lazy var publisher = Variable(emptyDefault)
    lazy var genre = Variable(emptyDefault)
    lazy var condition = Variable(emptyDefault)
    lazy var ownerBorrowerName = Variable(emptyDefault)
    lazy var dueDate = Variable(emptyDefault)
    lazy var comicID = Variable(emptyDefault)

    init(comic: DashboardComicUser) {
        dashboardComicUser = comic
        userType = comic.dashboardUserType
        setObservables()
    }

    func setObservables() {
        comicTitle.value = dashboardComicUser.dashboardComic.comicTitle
        storyTitle.value = dashboardComicUser.dashboardComic.storyTitle
        volume.value = dashboardComicUser.dashboardComic.volume ?? emptyDefault
        issue.value = dashboardComicUser.dashboardComic.issueNumber ?? emptyDefault
        if let dateRelease = dashboardComicUser.dashboardComic.releaseDate {
            releaseDate.value = formatDateToString(date: dateRelease)
        } else {
            releaseDate.value = emptyDefault
        }
        publisher.value = dashboardComicUser.dashboardComic.publisher ?? emptyDefault
        condition.value = dashboardComicUser.dashboardComic.condition ?? emptyDefault
        comicImage.value = getImage(imageURL: dashboardComicUser.dashboardComic.comicPhotoURL ?? emptyDefault)
        if let dateReturn = dashboardComicUser.dashboardComic.returnDate {
            dueDate.value = formatDateToString(date: dateReturn)
        } else {
            dueDate.value = "No due date"
        }
        if dashboardComicUser.dashboardUserType == .borrower {
            ownerBorrowerName.value = dashboardComicUser.dashboardUser?.firstName ?? emptyDefault
        } else if dashboardComicUser.dashboardUserType == .owner {
            ownerBorrowerName.value = dashboardComicUser.dashboardUser?.firstName ?? emptyDefault
        }
        comicID.value = dashboardComicUser.dashboardComic.comicID ?? emptyDefault
    }

    func getImage(imageURL: String) -> UIImage {
        guard let url = URL(string: imageURL),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data)
            else { return UIImage() }
        return image
    }

    func formatDateToString(date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL. dd"
        guard let date: Date = date else { return "No due date" }
        return "Due " + formatter.string(from: date)
    }
}
