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

/// Encapsulates optional Comic properties to circumvent 8 parameter limit of Observable.combineLatest.
struct OptionalComicFields {
    var volume: String?
    var issueNumber: String?
    var publisher: String?
    var releaseYear: String?
    var comicPhotoURL: String?
}

class ComicFormViewModel {

    // MARK: - RxSwift

    var comic: Observable<Comic> {
        let optionalObservable = Observable.combineLatest(volume.asObservable(), issue.asObservable(), publisher.asObservable(), release.asObservable(), coverPhotoURL.asObservable()) { volume, issue, publisher, release, coverPhotoURL in
            return OptionalComicFields(volume: volume, issueNumber: issue, publisher: publisher, releaseYear: release, comicPhotoURL: coverPhotoURL)
        }

        let comicFormViewModelAttributeObservables = Observable.combineLatest(
            seriesTitle.asObservable(),
            storyTitle.asObservable(),
            optionalObservable,
            condition.asObservable(),
            genre.asObservable()
        ) { seriesTitle, storyTitle, optionalFields, condition, genre in
            return Comic(seriesTitle: seriesTitle,
                         storyTitle: storyTitle,
                         optionalComicFields: optionalFields,
                         returnDate: nil,
                         condition: condition?.title,
                         genre: genre?.title)
        }

        return comicFormViewModelAttributeObservables
    }

    let seriesTitle = Variable("")
    let storyTitle = Variable("")
    let volume = Variable<String?>(nil)
    let issue = Variable<String?>(nil)
    let publisher = Variable<String?>(nil)
    let release = Variable<String?>(nil)
    let coverPhotoURL = Variable<String?>(nil)
    let condition = Variable<Comic.Condition?>(nil)
    let genre = Variable<Comic.Genre?>(nil)

    // MARK: - Variables

    var comicFormMode: ComicFormMode

    var navigationBarTitle: String {
        return comicFormMode == .add ? "Add Book" : "Edit Book"
    }
    var genreTitles: Observable<[String]> {
        return Observable.just(Comic.Genre.allCases.map { $0.title })
    }
    var conditionTitles: Observable<[String]> {
        return Observable.just(Comic.Condition.allCases.map { $0.title })
    }

    var coverPhoto: UIImage?

    // MARK: - Private Variables

    private let disposeBag = DisposeBag()
    private let lucienAPIClient = LucienAPIClient()

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
        self.genre.value = genre
        self.condition.value = condition
    }

    // MARK: - Instance Methods

    func finishButtonTapped(completion: @escaping (Error?) -> Void) {
        createPhotoURLAndUploadImage(image: coverPhoto) { [weak self] publicURL in
            self?.coverPhotoURL.value = publicURL
            guard
                let comic = self?.comic,
                let disposeBag = self?.disposeBag
                else { return }

            comic.asObservable().subscribe(onNext: { comic in
                self?.addComicBook(comic: comic, completion: completion)
            }) >>> disposeBag
        }
    }

    private func addComicBook(comic: Comic, completion: @escaping (Error?) -> Void) {
        lucienAPIClient.addComicBook(comic: comic) { response in
            switch response {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    private func createPhotoURLAndUploadImage(image: UIImage?, completion: @escaping (String) -> Void) {
        guard let image = image else {
            completion("")
            return
        }
        lucienAPIClient.createPhotoURLAndUploadImage { [weak self] response in
            switch response {
            case .success(let url):
                self?.upload(image: image, urlString: url.preSignedURL) { _ in
                    completion(url.publicURL)
                }
            case .failure:
                completion("")
            }
        }
    }

    private func upload(image: UIImage, urlString: String, completion: @escaping (Error?) -> Void) {
        guard let imageData = UIImageJPEGRepresentation(image, LucienConstants.compressionQuality) else { return }
        lucienAPIClient.sendRequestToS3(data: imageData, urlString: urlString, completion: completion)
    }
}
