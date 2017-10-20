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
    var lendingComicCount: Int
    var borrowingComicCount: Int
    var lendingComics: [DashboardComicUser]
    var borrowingComics: [DashboardComicUser]

    enum CodingKeys: String, CodingKey {
        case myCollectionCount = "my_collection_count_by_issue"
        case lendingComicCount = "lending_count"
        case borrowingComicCount = "borrowing_count"
        case lendingComics = "lending"
        case borrowingComics = "borrowing"
    }
}
