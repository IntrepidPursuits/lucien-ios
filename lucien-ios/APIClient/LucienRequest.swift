//
//  LucienRequest.swift
//
//  Created by Mark Daigneault on 5/3/16.
//  Copyright © 2016 Intrepid Pursuits. All rights reserved.
//

import Foundation

enum LucienRequest: Request {

    static let baseURL = "https://lucien-server-staging.herokuapp.com"
    static let acceptHeader: String? = "application/vnd.lucien-app.com; version=1"
    static var authorizationHeader: String = ""

    case authenticate(code: String)
    case getCurrentUser()
    case getDashboard()
    case hasCollection()

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
        }
    }

    var queryParameters: [String : Any]? {
        switch self {
        case .authenticate, .getCurrentUser:
            return nil
        case .getDashboard:
            return nil
        case .hasCollection:
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
        }
    }

    var contentType: String {
        switch self {
    case .authenticate, .getCurrentUser, .getDashboard, .hasCollection:
            return "Application/JSON"
        }
    }
}
