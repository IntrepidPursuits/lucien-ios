//
//  LucienRequest.swift
//
//  Created by Mark Daigneault on 5/3/16.
//  Copyright © 2016 Intrepid Pursuits. All rights reserved.
//

import Foundation

enum LucienRequest: Request {

    static let baseURL = "https://lucien-server-staging.herokuapp.com"
    static let acceptHeader = "application/vnd.lucien-app.com; version=1"
    static var authorizationHeader = ""

    case authenticate(code: String)
    case getCurrentUser
    case getDashboard
    case hasCollection
    case createPhotoURL
    case addComicBook(comicTitle: String,
                      storyTitle: String,
                      volume: String?,
                      issueNumber: String?,
                      publisher: String?,
                      releaseYear: String?,
                      comicPhotoURL: String?,
                      returnDate: String?,
                      condition: String?,
                      genre: String?)

    var method: HTTPMethod {
        switch self {
        case .authenticate:
            return .POST
        case .getCurrentUser:
            return .GET
        case .getDashboard:
            return .GET
        case .hasCollection:
            return .GET
        case .createPhotoURL:
            return .POST
        case .addComicBook:
            return .POST
        }
    }

    var path: String {
        switch self {
        case .authenticate:
            return "/authentications"
        case .getCurrentUser:
            return "/current_user"
        case .getDashboard:
            return "/dashboard"
        case .hasCollection:
            return "/has_collection"
        case .createPhotoURL:
            return "/comic_photo_urls"
        case .addComicBook:
            return "/my_comics"
        }
    }

    var authenticated: Bool {
        switch self {
        case .authenticate:
            return false
        case .getCurrentUser:
            return true
        case .getDashboard:
            return true
        case .hasCollection:
            return true
        case .createPhotoURL:
            return true
        case .addComicBook:
            return true
        }
    }

    var queryParameters: [String : Any]? {
        switch self {
        case .authenticate, .getCurrentUser, .getDashboard, .hasCollection, .createPhotoURL, .addComicBook:
            return nil
        }
    }

    var bodyParameters: [String : Any]? {
        switch self {
        case .authenticate(let code):
            return ["auth": ["token": code]]
        case .getCurrentUser:
            return nil
        case .getDashboard:
            return nil
        case .hasCollection:
            return nil
        case .createPhotoURL:
            return nil
        case .addComicBook(let comicTitle,
                           let storyTitle,
                           let volume,
                           let issueNumber,
                           let publisher,
                           let releaseYear,
                           let comicPhotoURL,
                           let returnDate,
                           let condition,
                           let genre):
            return ["comic": ["comic_title": comicTitle,
                              "story_title": storyTitle,
                              "volume": volume,
                              "issue_number": issueNumber,
                              "publisher": publisher,
                              "release_year": releaseYear,
                              "comic_photo_url": comicPhotoURL,
                              "return_date": returnDate,
                              "condition": condition,
                              "genre": genre]]
        }
    }

    var contentType: String {
        switch self {
        case .authenticate, .getCurrentUser, .getDashboard, .hasCollection, .createPhotoURL, .addComicBook:
            return "Application/JSON"
        }
    }
}
