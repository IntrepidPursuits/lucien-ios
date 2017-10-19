//
//  ComicFormViewModel.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
/// Specifies whether the ComicFormViewController will "add" comic books or "edit" comic books in a users collection.
enum  ComicFormMode {
    case add
    case edit
}

struct ComicFormViewModel {
    var coverPhoto: UIImage?
    var comicFormMode: ComicFormMode
    var seriesTitle: String?
    var volume: String?
    var storyTitle: String?
    var issue: String?
    var publisher: String?
    var release: String?
    var genre: Genre?
    var condition: Condition?
    var navigationBarTitle: String {
        return comicFormMode == .add ? "Add Book" : "Edit Book"
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
         genre: Genre?,
         condition: Condition?) {
        comicFormMode = .edit
        self.coverPhoto = coverPhoto
        self.seriesTitle = seriesTitle
        self.volume = volume
        self.storyTitle = storyTitle
        self.issue = issue
        self.publisher = publisher
        self.release = release
        self.genre = genre
        self.condition = condition
    }
}
