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
    static var authorizationHeader: String?

    case authenticate(code: String)
    case getCurrentUser()

    var method: HTTPMethod {
        switch self {
        case .authenticate:
            return .POST
        case .getCurrentUser:
            return .GET
        }
    }
    var path: String {
        switch self {
        case .authenticate:
            return "/authentications"
        case .getCurrentUser:
            return "/current_user"
        }
    }

    var authenticated: Bool {
        switch self {
        case .authenticate:
            return false
        case .getCurrentUser:
            return true
        }
    }

    var queryParameters: [String : Any]? {
        switch self {
        case .authenticate:
            return nil
        case .getCurrentUser:
            return nil
        }
    }

    var bodyParameters: [String : Any]? {
        switch self {
        case .authenticate(let code):
            return ["auth": ["token": code]]
        case .getCurrentUser:
            return nil
        }
    }

    var contentType: String {
        switch self {
        case .authenticate:
            return "Application/JSON"
        case .getCurrentUser:
            return "Application/JSON"
        }
    }
}
