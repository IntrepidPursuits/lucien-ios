//
//  Comic.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/2/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

struct Comic {

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
    }
}
