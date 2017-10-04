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
    case addComicBook(comic: Comic)
    case editComicBook(comicID: String, comic: Comic)

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
        case .editComicBook:
            return .PATCH
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
        case .editComicBook(let comicID, _):
            return "/my_comics/\(comicID)"
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
        case .editComicBook:
            return true
        }
    }

    var queryParameters: [String : Any]? {
        switch self {
        case .authenticate, .getCurrentUser, .getDashboard, .hasCollection, .createPhotoURL, .addComicBook, .editComicBook:
            return nil
        }
    }

    var body: Data? {
        let encoder = JSONEncoder()
        switch self {
        case .authenticate(let code):
            return try? encoder.encode(AuthenticationRequestBody(code: code))
        case .getCurrentUser:
            return nil
        case .getDashboard:
            return nil
        case .hasCollection:
            return nil
        case .createPhotoURL:
            return nil
        case .addComicBook(let comic):
            return try? encoder.encode(ComicRequestBody(comic: comic))
        case .editComicBook(_, let comic):
            return try? encoder.encode(ComicRequestBody(comic: comic))
        }
    }

    var contentType: String {
        switch self {
        case .authenticate, .getCurrentUser, .getDashboard, .hasCollection, .createPhotoURL, .addComicBook, .editComicBook:
            return "Application/JSON"

        }
    }
}
