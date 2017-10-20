//
//  DashboardComic.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/19/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct DashboardComic: Comic, Decodable {

    var comicID: String?
    var comicTitle: String
    var storyTitle: String
    var volume: String?
    var issueNumber: String?
    var publisher: String?
    var releaseDate: Date?
    var comicPhotoURL: String?
    var returnDate: Date?
    var condition: String?
    var genre: String?
    var releaseYear: Int?

    var createdAt: Date?
    var updatedAt: Date?
    var ownerID: String?
    var borrowerID: String?

    enum CodingKeys: String, CodingKey {
        case comicID = "id"
        case comicTitle = "comic_title"
        case storyTitle = "story_title"
        case volume
        case issueNumber = "issue_number"
        case publisher
        case releaseDate = "release_date"
        case comicPhotoURL = "comic_photo_url"
        case returnDate = "return_date"
        case condition
        case genre
        case releaseYear = "release_year"

        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case ownerID = "owner_id"
        case borrowerID = "borrower_id"
    }
}
