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
    var googlePictureURL: String
    var userID: String
    var googleUserID: String
    var createdAt: Date
    var updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case user
    }
    enum UserKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case googlePictureURL = "google_picture_url"
        case userID = "id"
        case googleUserID = "google_user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let userContainer = try values.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        firstName = try userContainer.decode(String.self, forKey: .firstName)
        lastName = try userContainer.decode(String.self, forKey: .lastName)
        email = try userContainer.decode(String.self, forKey: .email)
        googlePictureURL = try userContainer.decode(String.self, forKey: .googlePictureURL)
        userID = try userContainer.decode(String.self, forKey: .userID)
        googleUserID = try userContainer.decode(String.self, forKey: .googleUserID)
        createdAt = try userContainer.decode(Date.self, forKey: .createdAt)
        updatedAt = try userContainer.decode(Date.self, forKey: .updatedAt)
    }

}




