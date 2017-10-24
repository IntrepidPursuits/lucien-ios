//
//  User.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

struct User: Decodable {

    var firstName: String
    var lastName: String
    var email: String
    var googlePictureURL: String?
    var userID: String
    var googleUserID: String
    var createdAt: Date
    var updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case googlePictureURL = "google_picture_url"
        case userID = "id"
        case googleUserID = "google_user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct User2: Decodable {

    var firstName: String
    var lastName: String

    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
