//
//  AuthenticationResponse.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/6/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct AuthenticationToken: Codable {
    var token: String
}

struct AuthenticationRequestBody: Encodable {
    var auth: AuthenticationToken

    init(code: String) {
        auth = AuthenticationToken(token: code)
    }
}
