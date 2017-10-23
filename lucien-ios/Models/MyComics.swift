//
//  MyComics.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/23/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct MyComics: Decodable {

    var myComics: [Comic]

    enum CodingKeys: String, CodingKey {
        case myComics = "my_comics"
    }

    
}
