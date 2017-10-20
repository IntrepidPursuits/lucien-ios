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

    init(dashboard: Dashboard) {
        dashboardData = dashboard
    }

    var lendingViewModel: DashboardCollectionViewModel {
        return DashboardCollectionViewModel(comics: (dashboardData.lendingComics))
    }

    var borrowingViewModel: DashboardCollectionViewModel {
        return DashboardCollectionViewModel(comics: (dashboardData.borrowingComics))
    }
}
