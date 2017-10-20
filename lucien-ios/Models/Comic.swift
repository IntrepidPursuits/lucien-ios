//
//  Comic.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/2/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct Comic: Codable {
    var comicID: String?
    var comicTitle: String
    var storyTitle: String
    var volume: String?
    var issueNumber: String?
    var publisher: String?
    var releaseYear: String?
    var comicPhotoURL: String?
    var returnDate: String?
    var condition: String?
    var genre: String?

    private enum CodingKeys: String, CodingKey {
        case comicID = "id"
        case comicTitle = "comic_title"
        case storyTitle = "story_title"
        case volume = "volume"
        case issueNumber = "issue_number"
        case publisher = "publisher"
        case releaseYear = "release_year"
        case comicPhotoURL = "comic_photo_url"
        case returnDate = "return_date"
        case condition = "condition"
        case genre = "genre"
    }

    init(comicID: String? =  nil,
         comicTitle: String,
         storyTitle: String,
         optionalComicFields: OptionalComicFields? = nil,
         returnDate: String? = nil,
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
    var comic: Comic

    init(comic: Comic) {
        self.comic = comic
    }
}

extension Comic {
    enum Condition: Int {
        case nearMint
        case veryFine
        case fine
        case veryGood
        case good
        case fair
        case poor

        var title: String {
            switch self {
            case .nearMint:
                return "Near Mint"
            case .veryFine:
                return "Very Fine"
            case .fine:
                return "Fine"
            case .veryGood:
                return "Very Good"
            case .good:
                return "Good"
            case .fair:
                return "Fair"
            case .poor:
                return "Poor"
            }
        }

        static func convertStringToCondition(condition: String?) -> Condition? {
            guard let condition = condition else { return nil }
            return Condition.allCases.filter { $0.title == condition }.first
        }
    }

    enum Genre: Int {
        case action
        case childrens
        case comedy
        case crime
        case drama
        case fantasy
        case graphicNovels
        case historical
        case horror
        case lgtbq
        case literature
        case manga
        case mature
        case moviesAndTV
        case music
        case mystery
        case nonFiction
        case originalSeries
        case political
        case postApocalyptic
        case religious
        case romance
        case schoolLife
        case scienceFiction
        case sliceOfLife
        case superhero
        case supernatural
        case suspense
        case western

        var title: String {
            switch self {
            case .action:
                return "Action/Adventure"
            case .childrens:
                return "Children’s"
            case .comedy:
                return "Comedy"
            case .crime:
                return "Crime"
            case .drama:
                return "Drama"
            case .fantasy:
                return "Fantasy"
            case .graphicNovels:
                return "Graphic Novels"
            case .historical:
                return "Historical"
            case .horror:
                return "Horror"
            case .lgtbq:
                return "LGTBQ"
            case .literature:
                return "Literature"
            case .manga:
                return "Manga"
            case .mature:
                return "Mature"
            case .moviesAndTV:
                return "Movies & TV"
            case .music:
                return "Music"
            case .mystery:
                return "Mystery"
            case .nonFiction:
                return "Non-Fiction"
            case .originalSeries:
                return "Original Series"
            case .political:
                return "Political"
            case .postApocalyptic:
                return "Post-Apocalyptic"
            case .religious:
                return "Religious"
            case .romance:
                return "Romance"
            case .schoolLife:
                return "School Life"
            case .scienceFiction:
                return "Science Fiction"
            case .sliceOfLife:
                return "Slice of Life"
            case .superhero:
                return "Superhero"
            case .supernatural:
                return "Supernatural/Occult"
            case .suspense:
                return "Suspense"
            case .western:
                return "Western"

            }
        }

        static func convertStringToGenre(genre: String?) -> Genre? {
            guard let genre = genre else { return nil }
            return Genre.allCases.filter { $0.title == genre }.first
        }
    }
}
