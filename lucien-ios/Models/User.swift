//
//  User.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

private struct User: Decodable {
    let firstName: String
    let lastName: String
    let email: String
    let googlePictureURL: String
    let userID: Int
    let googleUserID: Int
    let createdAt: Date
    let updatedAt: Date

//    enum CodingKeys: String, CodingKey {
//        case firstName: '
//        case lastName: String
//        case email: String
//        case googlePictureURL: String
//        case userID: Int
//        case googleUserID: Int
//        case createdAt: Date
//        case updatedAt: Date
//
//    }
}
