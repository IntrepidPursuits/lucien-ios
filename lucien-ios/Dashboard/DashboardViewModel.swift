//
//  DashboardViewModel.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/12/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

final class DashboardViewModel {

    static let lendingCellTitles = ["Princess", "Gracie", "Kittens"]
    let lucienAPIClient = LucienAPIClient()
    var dashboardData: Dashboard?

    func getDashboard(completion: @escaping () -> Void) {
        lucienAPIClient.getDashboard { response in
            switch response {
            case .success(let result):
                self.dashboardData = result
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}
