//
//  S3ImageURL.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/12/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct S3ImageURL: Decodable {
    var preSignedURL: String
    var publicURL: String


    enum CodingKeys: String, CodingKey {
        case s3Object = "s3_object"
    }

    enum S3URLKeys: String, CodingKey {
        case preSignedURL = "presigned_url"
        case publicURL = "public_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let s3ObjectContainer = try values.nestedContainer(keyedBy: S3URLKeys.self, forKey: .s3Object)
        preSignedURL = try s3ObjectContainer.decode(String.self, forKey: .preSignedURL)
        publicURL = try s3ObjectContainer.decode(String.self, forKey: .publicURL)
    }
}

