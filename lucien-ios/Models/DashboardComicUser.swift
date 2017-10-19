//
//  DashboardComicUser.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/18/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

enum DashboardComicUserError: Error {
    case noUser
    case noComics
}

struct DashboardComicUser: Decodable {
    var dashboardComic: DashboardComic
    var dashboardUser: User
    var dashboardUserType: UserType

    enum UserType: String {
        case borrower
        case owner
        case none
    }

    enum CodingKeys: String, CodingKey {
        case borrower
        case owner
    }

    init(dashboardComic: DashboardComic, dashboardUser: User, dashboardUserType: UserType) {
        self.dashboardComic = dashboardComic
        self.dashboardUser = dashboardUser
        self.dashboardUserType = dashboardUserType
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DashboardComic.CodingKeys.self)
        let id = try container.decode(String.self, forKey: .comicID)
        let comicTitle = try container.decode(String.self, forKey: .comicTitle)
        let storyTitle = try container.decode(String.self, forKey: .storyTitle)
        let volume = try? container.decode(String.self, forKey: .volume)
        let issueNumber = try? container.decode(String.self, forKey: .issueNumber)
        let publisher = try? container.decode(String.self, forKey: .publisher)
        let releaseDate = try? container.decode(Date.self, forKey: .releaseDate)
        let comicPhotoURL = try? container.decode(String.self, forKey: .comicPhotoURL)
        let returnDate = try? container.decode(Date.self, forKey: .returnDate)
        let condition = try? container.decode(String.self, forKey: .condition)
        let genre = try? container.decode(String.self, forKey: .genre)
        let releaseYear = try? container.decode(Int.self, forKey: .releaseYear)
        let createdAt = try? container.decode(Date.self, forKey: .createdAt)
        let updatedAt = try? container.decode(Date.self, forKey: .updatedAt)
        let ownerID = try container.decode(String.self, forKey: .ownerID)
        let borrowerID = try? container.decode(String.self, forKey: .borrowerID)

        let userContainer = try decoder.container(keyedBy: CodingKeys.self)
        let owner = try userContainer.decodeIfPresent(User.self, forKey: .owner)
        let borrower = try userContainer.decodeIfPresent(User.self, forKey: .borrower)

        let comic = DashboardComic(comicID: id, comicTitle: comicTitle, storyTitle: storyTitle, volume: volume, issueNumber: issueNumber, publisher: publisher, releaseDate: releaseDate, comicPhotoURL: comicPhotoURL, returnDate: returnDate, condition: condition, genre: genre, releaseYear: releaseYear, createdAt: createdAt, updatedAt: updatedAt, ownerID: ownerID, borrowerID: borrowerID)

        guard let user = owner ?? borrower else { throw DashboardComicUserError.noUser }

        var dashUserType: UserType {
            if owner != nil {
                return UserType.owner
            } else if borrower != nil {
                return UserType.borrower
            } else { return UserType.none }
        }
        self.init(dashboardComic: comic, dashboardUser: user, dashboardUserType: dashUserType)
    }
}
