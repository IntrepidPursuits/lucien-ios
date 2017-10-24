//
//  LentComic.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/24/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct LentComic: Codable {
    var borrowerID: String
    var returnDate: String

    enum CodingKeys: String, CodingKey {
        case borrowerID = "borrower_id"
        case returnDate = "return_date"
    }

    init(borrowerID: String, returnDate: String) {
        self.borrowerID = borrowerID
        self.returnDate = returnDate
    }
}

struct LentComicRequestBody: Encodable {
    var comic: LentComic?
    init(comic: LentComic) {
        self.comic = comic
    }
}
