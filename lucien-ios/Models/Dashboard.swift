//
//  MyCollection.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/5/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct Dashboard: Decodable {
    var myCollectionCount: Int

    enum CodingKeys: String, CodingKey {
        case dashboard
    }

    enum DashboardKeys: String, CodingKey {
        case myCollectionCount = "my_collection_count_by_issue"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dashboardContainer = try values.nestedContainer(keyedBy: DashboardKeys.self, forKey: .dashboard)
        myCollectionCount = try dashboardContainer.decode(Int.self, forKey: .myCollectionCount)
    }
}
