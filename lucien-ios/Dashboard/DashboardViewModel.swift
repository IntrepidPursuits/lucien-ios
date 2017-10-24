//
//  DashboardViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/12/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

final class DashboardViewModel {

    let lucienAPIClient = LucienAPIClient()
    private var dashboardData: Dashboard
    private var myComicList: [DashboardComicUser]

    init(dashboard: Dashboard, myComics: [DashboardComicUser]) {
        dashboardData = dashboard
        myComicList = myComics
    }

    var lendingViewModel: DashboardCollectionViewModel {
        return DashboardCollectionViewModel(comics: (dashboardData.lendingComics))
    }

    var borrowingViewModel: DashboardCollectionViewModel {
        return DashboardCollectionViewModel(comics: (dashboardData.borrowingComics))
    }

    var myComicsViewModel: DashboardTableViewModel {
        return DashboardTableViewModel(comics: myComicList)
    }
}
