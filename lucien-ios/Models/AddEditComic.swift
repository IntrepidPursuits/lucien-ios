//
//  AddEditComic.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/20/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//


import Foundation

struct AddEditComic: Comic, Codable {
    
    var comicID: String?
    var comicTitle: String
    var storyTitle: String
    var volume: String?
    var issueNumber: String?
    var publisher: String?
    var releaseDate: Date?
    var comicPhotoURL: String?
    var returnDate: Date?
    var condition: String?
    var genre: String?
    var releaseYear: String?
    
    enum CodingKeys: String, CodingKey {
        case comicID = "id"
        case comicTitle = "comic_title"
        case storyTitle = "story_title"
        case volume = "volume"
        case issueNumber = "issue_number"
        case publisher = "publisher"
        case releaseDate = "release_date"
        case comicPhotoURL = "comic_photo_url"
        case returnDate = "return_date"
        case condition = "condition"
        case genre = "genre"
        case releaseYear = "release_year"
    }
    
    init(comicID: String? =  nil,
         comicTitle: String,
         storyTitle: String,
         optionalComicFields: OptionalComicFields? = nil,
         returnDate: Date? = nil,
         condition: String? = nil,
         genre: String? = nil) {
        self.comicID = comicID
        self.comicTitle = comicTitle
        self.storyTitle = storyTitle
        self.volume = optionalComicFields?.volume
        self.issueNumber = optionalComicFields?.issueNumber
        self.publisher = optionalComicFields?.publisher
        self.releaseYear = optionalComicFields?.releaseYear
        self.comicPhotoURL = optionalComicFields?.comicPhotoURL
        self.returnDate = returnDate
        self.condition = condition
        self.genre = genre
    }
}

struct ComicRequestBody: Encodable {
    var comic: AddEditComic?
    init(comic: AddEditComic) {
        self.comic = comic
    }
}
