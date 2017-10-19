//
//  DashboardComic.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/18/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

enum DashboardComicError: Error {
    case noUser
    case noComics
}

struct DashboardComic: Decodable {
    var dashboardComic: Comic
    var dashboardUser: User
    var dashboardUserType: String

    enum CodingKeys: String, CodingKey {
        case borrower
        case owner
    }

    init(dashboardComic: Comic, dashboardUser: User, dashboardUserType: String) {
        self.dashboardComic = dashboardComic
        self.dashboardUser = dashboardUser
        self.dashboardUserType = dashboardUserType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Comic.CodingKeys.self)
        let id = try container.decode(String.self, forKey: .comicID)
        let createdAt = try? container.decode(Date.self, forKey: .createdAt)
        let updatedAt = try? container.decode(Date.self, forKey: .updatedAt)
        let ownerID = try container.decode(String.self, forKey: .ownerID)
        let borrowerID = try? container.decode(String.self, forKey: .borrowerID)
        let comicTitle = try container.decode(String.self, forKey: .comicTitle)
        let storyTitle = try? container.decode(String.self, forKey: .storyTitle)
        let volume = try? container.decode(String.self, forKey: .volume)
        let issueNumber = try? container.decode(String.self, forKey: .issueNumber)
        let publisher = try? container.decode(String.self, forKey: .publisher)
        let releaseDate = try? container.decode(Date.self, forKey: .releaseDate)
        let comicPhotoURL = try? container.decode(String.self, forKey: .comicPhotoURL) 
        let returnDate = try? container.decode(Date.self, forKey: .returnDate)
        let condition = try? container.decode(String.self, forKey: .condition)
        let genre = try? container.decode(String.self, forKey: .genre)
        let releaseYear = try? container.decode(Int.self, forKey: .releaseYear)
        let userContainer = try decoder.container(keyedBy: CodingKeys.self)
        let owner = try userContainer.decodeIfPresent(User.self, forKey: .owner)
        let borrower = try userContainer.decodeIfPresent(User.self, forKey: .borrower)

        let comic = Comic(comicID: id, createdAt: createdAt, updatedAt: updatedAt, ownerID: ownerID, borrowerID: borrowerID, comicTitle: comicTitle, storyTitle: storyTitle, volume: volume, issueNumber: issueNumber, publisher: publisher, releaseDate: releaseDate, comicPhotoURL: comicPhotoURL, returnDate: returnDate, condition: condition, genre: genre, releaseYear: releaseYear)

        guard let user = owner ?? borrower else { throw DashboardComicError.noUser }

        var userType: String {
            if owner != nil {
                return "owner"
            } else if borrower != nil {
                return "borrower"
            } else { return "" }
        }

        self.init(dashboardComic: comic, dashboardUser: user, dashboardUserType: userType)
    }
}
