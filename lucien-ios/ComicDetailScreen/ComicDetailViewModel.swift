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

    private var dashboardComicUser: DashboardComicUser

    let emptyDefault = "-"
    let comicImage = Variable(UIImage())
    lazy var comicTitle = Variable(emptyDefault)
    lazy var storyTitle = Variable(emptyDefault)
    lazy var volume = Variable(emptyDefault)
    lazy var issue = Variable(emptyDefault)
    lazy var releaseDate = Variable(emptyDefault)
    lazy var publisher = Variable(emptyDefault)
    lazy var genre = Variable(emptyDefault)
    lazy var condition = Variable(emptyDefault)
    lazy var borrowerName = Variable(emptyDefault)

    init(comic: DashboardComicUser) {
        dashboardComicUser = comic
        setObservables()
    }

    func setObservables() {
        comicTitle.value = dashboardComicUser.dashboardComic.comicTitle
        storyTitle.value = dashboardComicUser.dashboardComic.storyTitle
        volume.value = dashboardComicUser.dashboardComic.volume ?? ""
        issue.value = dashboardComicUser.dashboardComic.issueNumber ?? ""
        if let date = dashboardComicUser.dashboardComic.releaseDate {
            releaseDate.value = DateFormatter().string(from: date)
        }
        publisher.value = dashboardComicUser.dashboardComic.publisher ?? ""
        condition.value = dashboardComicUser.dashboardComic.condition ?? ""
        comicImage.value = getImage(imageURL: dashboardComicUser.dashboardComic.comicPhotoURL ?? "")
        if dashboardComicUser.dashboardUserType
        borrowerName.value = dashboardComicUser.
    }

    func getImage(imageURL: String) -> UIImage {
        guard let url = URL(string: imageURL) else { return UIImage() }
        guard let data = try? Data(contentsOf: url) else {
            return UIImage()
        }
        guard let image = UIImage(data: data) else { return UIImage() }
        return image
    }
}
