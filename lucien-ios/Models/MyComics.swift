//
//  MyComics.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/23/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct MyComics: Decodable {
    var myCollection: [DashboardComicUser]

    enum CodingKeys: String, CodingKey {
        case myCollection = "my_comics"
    }
}
