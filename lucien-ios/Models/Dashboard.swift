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
    var lendingCount: Int

    enum CodingKeys: String, CodingKey {
        case myCollectionCount = "my_collection_count_by_issue"
        case lendingCount = "lending_count"
    }
}
