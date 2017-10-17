//
//  ComicFormViewModel.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

/// Specifies whether the ComicFormViewController will "add" comic books or "edit" comic books in a users collection.
enum  ComicFormMode {
    case add
    case edit
}

struct ComicFormViewModel {
    var coverPhoto: UIImage?
    var comicFormMode: ComicFormMode
    var seriesTitle = Variable<String>("")
    var volume = Variable<String>("")
    var storyTitle = Variable<String>("")
    var issue = Variable<String>("")
    var publisher = Variable<String>("")
    var release = Variable<String>("")
    var genre: Comic.Genre?
    var condition: Comic.Condition?
    var navigationBarTitle: String {
        return comicFormMode == .add ? "Add Book" : "Edit Book"
    }
    var genreTitles: Observable<[String]> {
        return Observable.just(Comic.Genre.allCases.map { $0.title })
    }
    var conditionTitles: Observable<[String]> {
        return Observable.just(Comic.Condition.allCases.map { $0.title })
    }

    // ComicFormMode is set to .add by default if default init is used.
    init() {
        comicFormMode = .add
    }

    /// Initializes ComicFormViewModel with a ComicFormMode of edit.
    /// The parameters will be used by the ComicFormViewController to fill in its textfields.
    init(coverPhoto: UIImage?,
         seriesTitle: String,
         volume: String?,
         storyTitle: String,
         issue: String?,
         publisher: String?,
         release: String?,
         genre: Comic.Genre?,
         condition: Comic.Condition?) {
        comicFormMode = .edit
        self.coverPhoto = coverPhoto
        self.seriesTitle.value = seriesTitle
        self.volume.value = volume ?? ""
        self.storyTitle.value = storyTitle
        self.issue.value = issue ?? ""
        self.publisher.value = publisher ?? ""
        self.release.value = release ?? ""
        self.genre = genre
        self.condition = condition
    }
}
