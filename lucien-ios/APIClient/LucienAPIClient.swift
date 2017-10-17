//
//  LucienAPIClient.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

enum LucienAPIError: Error {
    case noResult
    case cannotDecode
}

final class LucienAPIClient: APIClient {

    func authenticateUser(code: String, completion: @escaping (Result<AuthenticationResponse>) -> Void) {
        let urlRequest = LucienRequest.authenticate(code: code).urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                do {
                    let decoder = JSONDecoder()
                    let authenticationResponse = try decoder.decode(AuthenticationResponse.self, from: result)
                    completion(.success(authenticationResponse))
                } catch(let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getCurrentUser(completion: @escaping (Result<User>) -> Void) {
        let urlRequest = LucienRequest.getCurrentUser.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let user = try decoder.decode(User.self, from: result)
                    completion(.success(user))
                } catch(let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getDashboard(completion: @escaping (Result<Dashboard>) -> Void) {
        let urlRequest = LucienRequest.getDashboard.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                let decoder = JSONDecoder()
                guard let myCollection = try? decoder.decode(Dashboard.self, from: result) else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                completion(.success(myCollection))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func hasCollection(completion: @escaping (Result<Bool>) -> Void) {
        let urlRequest = LucienRequest.hasCollection.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                guard let resultString = String(data: result, encoding: String.Encoding.utf8) else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                 let hasCollection = (resultString as NSString).boolValue
                completion(.success(hasCollection))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func createPhotoURL(completion: @escaping (Result<S3ImageURL>) -> Void) {
        let lucienRequest = LucienRequest.createPhotoURL
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                guard let s3ImageURL = try? decoder.decode(S3ImageURL.self, from: result) else {
                    return completion(.failure(LucienAPIError.cannotDecode))
                }
                completion(.success(s3ImageURL))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

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
                      completion: @escaping (Result<Error?>) -> Void) {
        let lucienRequest = LucienRequest.addComicBook(comicTitle: comicTitle,
                                                       storyTitle: storyTitle,
                                                       volume: volume,
                                                       issueNumber: issueNumber,
                                                       publisher: publisher,
                                                       releaseYear: releaseYear,
                                                       comicPhotoURL: comicPhotoURL,
                                                       returnDate: returnDate,
                                                       condition: condition,
                                                       genre: genre)
        let urlRequest = lucienRequest.urlRequest
        self.sendRequest(urlRequest) { response in
            print(response)
            switch response {
            case .success(let _):
                completion(.success(nil))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
