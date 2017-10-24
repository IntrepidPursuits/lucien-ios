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

    let comicImage = Variable(UIImage())
    let comicTitle = Variable("-")
    let storyTitle = Variable("-")
    let volume = Variable("-")
    let issue = Variable("-")
    let releaseDate = Variable("-")
    let publisher = Variable("-")
    let genre = Variable("-")
    let condition = Variable("-")

    init(comic: DashboardComicUser) {
        dashboardComicUser = comic
        setObservables()
    }

    func setObservables() {
        comicTitle.value = dashboardComicUser.dashboardComic.comicTitle
        storyTitle.value = dashboardComicUser.dashboardComic.storyTitle
        volume.value = dashboardComicUser.dashboardComic.volume ?? ""
        issue.value = dashboardComicUser.dashboardComic.issueNumber ?? ""
        guard let date = dashboardComicUser.dashboardComic.releaseDate else { return }
        releaseDate.value = DateFormatter().string(from: date)
        publisher.value = dashboardComicUser.dashboardComic.publisher ?? ""
        condition.value = dashboardComicUser.dashboardComic.condition ?? ""
        comicImage.value = getImage(imageURL: dashboardComicUser.dashboardComic.comicPhotoURL ?? "")
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
