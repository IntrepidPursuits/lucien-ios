//
//  LucienRequest.swift
//
//  Created by Mark Daigneault on 5/3/16.
//  Copyright © 2016 Intrepid Pursuits. All rights reserved.
//

import Foundation

enum LucienRequest: Request {

    static let baseURL = "https://lucien-server-staging.herokuapp.com/api/v1"
    static var acceptHeader: String? = ""

    case authenticate(code: String)

    var method: HTTPMethod {
        switch self {
        case .authenticate:
            return .POST
        }
    }
    var path: String {
        switch self {
        case .authenticate:
            return "authentications"
        }
    }

    var authenticated: Bool {
        switch self {
        case .authenticate:
            return false
        }
    }

    var queryParameters: [String : Any]? {
        switch self {
        case .authenticate:
            return [:]
        }
    }

    var bodyParameters: [String : Any]? {
        switch self {
        case .authenticate:
            return [:]
        }
    }

    var contentType: String {
        switch self {
        case .authenticate:
            return "authentications"
        }
    }
}
