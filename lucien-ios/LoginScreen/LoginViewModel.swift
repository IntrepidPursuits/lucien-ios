//
//  LoginManager.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

final class LoginViewModel {

    let lucienAPIClient = LucienAPIClient()
    var currentUser: User?
    var hasCollection: Bool = false

    func getCurrentUser(completion: @escaping () -> Void) {
        lucienAPIClient.getCurrentUser { response in
            switch response {
            case .success(let user):
                self.currentUser = user
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }

    func authenticateUser(code: String, completion: @escaping () -> Void) {
        lucienAPIClient.authenticateUser(code: code) { response in
            switch response {
            case .success(let authenticationResponse):
                LucienRequest.authorizationHeader = "Bearer " + authenticationResponse.token
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }

    func hasCollection(completion: @escaping (Bool) -> Void) {
        lucienAPIClient.hasCollection { response in
            switch response {
            case .success(let result):
                completion(result)
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }

    // TODO: Replace completion (Error?) with completion (Comic?) when Comic model is complete.
    func addComicBook(comicTitle: String,
                      storyTitle: String,
                      volume: String?,
                      issueNumber: String?,
                      publisher: String?,
                      releaseYear: String?,
                      comicPhotoURL: String?,
                      returnDate: String?,
                      condition: String?,
                      genre: String?,
                      completion: @escaping (Error?) -> Void) {

        lucienAPIClient.addComicBook(comicTitle: comicTitle,
                                     storyTitle: storyTitle,
                                     volume: volume,
                                     issueNumber: issueNumber,
                                     publisher: publisher,
                                     releaseYear: releaseYear,
                                     comicPhotoURL: comicPhotoURL,
                                     returnDate: returnDate,
                                     condition: condition,
                                     genre: genre) { response in
                                    switch response {
                                    case .success:
                                        completion(nil)
                                    case .failure(let error):
                                        completion(error)
                                    }
        }
    }

    func createPhotoURL(image: UIImage?, completion: @escaping (String) -> Void) {
        guard let image = image else {
            completion("")
            return
        }
        lucienAPIClient.createPhotoURL { [weak self] response in
            switch response {
            case .success(let url):
                self?.upload(image: image, urlString: url.preSignedURL) { _ in
                    completion(url.publicURL)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func sendRequestToS3(data: Data, urlString: String, completion: @escaping (Error?) -> Void) {
        let requestURL = URL(string: urlString)!
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = data
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
        let task = URLSession.shared.dataTask(with: request) { _, _, error in
            if error == nil {
                completion(nil)
            }
            completion(error)
        }
        task.resume()
    }

    func upload(image: UIImage, urlString: String, completion: @escaping (Error?) -> Void) {
        guard let imageData = UIImageJPEGRepresentation(image, 0.9) else { return }
        sendRequestToS3(data: imageData, urlString: urlString, completion: completion)
    }
}
