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

    func authenticateUser(code: String, completion: @escaping (Result<AuthenticationToken>) -> Void) {
        let urlRequest = LucienRequest.authenticate(code: code).urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                do {
                    let decoder = JSONDecoder()
                    let authenticationToken = try decoder.decode(AuthenticationToken.self, from: result)
                    completion(.success(authenticationToken))
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
                    let userResponse = try decoder.decode(UserResponse.self, from: result)
                    completion(.success(userResponse.user))
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
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let dashboardResponse = try decoder.decode(DashboardResponse.self, from: result)
                    completion(.success(dashboardResponse.dashboard))
                } catch (let error) {
                    completion(.failure(error))
                }
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

    func getMyComics(completion: @escaping (Result<[DashboardComicUser]>) -> Void) {
        let urlRequest = LucienRequest.getMyComics.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let myComicResponse = try decoder.decode(MyComics.self, from: result)
                    completion(.success(myComicResponse.myCollection))
                } catch (let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /**
     Sends a request to the Lucien server to create a public URL for a comic book image.
     - parameter completion:
     */
    func createPhotoURLAndUploadImage(completion: @escaping (Result<AmazonS3ImageURL>) -> Void) {
        let lucienRequest = LucienRequest.createPhotoURL
        let urlRequest = lucienRequest.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }

                do {
                    let decoder = JSONDecoder()
                    let s3ImageURL = try decoder.decode(AmazonS3ImageURL.self, from: result)
                    completion(.success(s3ImageURL))
                } catch(let error) {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /**
     Sends a request to the Lucien server to upload an image to the specified presigned url.
     - parameter data: UIImage data.
     - parameter urlString: presigned url
     - parameter completion:
    */
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

    /**
     Sends a request to the Lucien server to add a comic book.
     - parameter comic: Comic Object
     - parameter completion:
     */
    func addComicBook(comic: AddEditComic, completion: @escaping (Result<Void>) -> Void) {
        let lucienRequest = LucienRequest.addComicBook(comic: comic)
        let urlRequest = lucienRequest.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /**
     Sends a request to the Lucien server to edit a comic book.
     - parameter comic: Comic Object
     - parameter completion:
     */
    func editComicBook(comicID: String, comic: AddEditComic, completion: @escaping (Result<Void>) -> Void) {
        let lucienRequest = LucienRequest.editComicBook(comicID: comicID, comic: comic)
        let urlRequest = lucienRequest.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getAllUsers(completion: @escaping (Result<[User]>) -> Void) {
        let lucienRequest = LucienRequest.getAllUsers
        let urlRequest = lucienRequest.urlRequest
        sendRequest(urlRequest) { response in
            switch response {
            case .success(let result):
                guard let result = result else {
                    return completion(.failure(LucienAPIError.noResult))
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let userResponse = try decoder.decode(AllUsersResponse.self, from: result)
                    completion(.success(userResponse.users))
                } catch(let error) {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
