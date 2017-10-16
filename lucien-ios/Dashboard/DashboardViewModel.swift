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
    static var dashboardData: Dashboard?

    func getDashboard(completion: @escaping () -> Void) {
        lucienAPIClient.getDashboard { response in
            switch response {
            case .success(let result):
                DashboardViewModel.dashboardData = result
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }
}
