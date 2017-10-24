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

    var comic: Observable<AddEditComic> {
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
            return AddEditComic(comicTitle: seriesTitle,
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
    let condition = Variable<Condition?>(nil)
    let genre = Variable<Genre?>(nil)

    // MARK: - Variables

    var comicFormMode = ComicFormMode.add
    var coverPhoto: UIImage?
    var navigationBarTitle: String {
        return comicFormMode == .add ? "Add Book" : "Edit Book"
    }

    var genreTitles: Observable<[String]> {
        return Observable.just(Genre.allCases.map { $0.title })
    }

    var conditionTitles: Observable<[String]> {
        return Observable.just(Condition.allCases.map { $0.title })
    }

    // MARK: - Private Variables

    private let disposeBag = DisposeBag()
    private let lucienAPIClient = LucienAPIClient()
    private var comicID: String? 

    init() {}

    /// Initializes ComicFormViewModel with a ComicFormMode of edit.
    /// The parameters will be used by the ComicFormViewController to fill in its textfields.
    init(comic: AddEditComic, coverPhoto: UIImage?) {
        comicFormMode = .edit
        self.comicID = comic.comicID
        self.coverPhoto = coverPhoto
        self.seriesTitle.value = comic.comicTitle
        self.volume.value = comic.volume ?? ""
        self.storyTitle.value = comic.storyTitle
        self.issue.value = comic.issueNumber ?? ""
        self.publisher.value = comic.publisher ?? ""
        self.release.value = comic.releaseYear ?? ""
        self.genre.value = Genre.convertStringToGenre(genre: comic.genre)
        self.condition.value = Condition.convertStringToCondition(condition: comic.condition)
    }


    func convertStringToCondition(condition: String?) -> Condition? {
        guard let condition = condition else { return nil }
        return Condition.allCases.filter { $0.title == condition }.first
    }

    // MARK: - Instance Methods

    func finishButtonTapped(completion: @escaping (Error?) -> Void) {
        createPhotoURLAndUploadImage(image: coverPhoto) { [weak self] publicURL in
            self?.coverPhotoURL.value = publicURL
            guard
                let comic = self?.comic,
                let disposeBag = self?.disposeBag
                else { return }

            comic.asObservable().single().subscribe(onNext: { comic in
                if self?.comicFormMode == .add {
                    self?.addComicBook(comic: comic, completion: completion)
                } else {
                    guard let comicID = self?.comicID else { return }
                    self?.editComicBook(comicID: comicID, comic: comic, completion: completion)
                }
            }) >>> disposeBag
        }
    }

    private func addComicBook(comic: AddEditComic, completion: @escaping (Error?) -> Void) {
        lucienAPIClient.addComicBook(comic: comic) { response in
            switch response {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }

    private func editComicBook(comicID: String, comic: AddEditComic, completion: @escaping (Error?) -> Void) {
        lucienAPIClient.editComicBook(comicID: comicID, comic: comic) { response in
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
