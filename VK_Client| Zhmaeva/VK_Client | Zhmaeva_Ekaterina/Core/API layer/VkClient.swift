//
//  NetworkLayer.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 10.08.2021.
//

import Foundation

// MARK: - VK Client

final class VkClient {

    // MARK: - Public property

    let network = NetworkLayer()


    // MARK: - Private property

    private let version = "5.131"


    // MARK: - Public methods

    func getAuthUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7923746"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: version)
        ]
        guard let url = urlComponents.url else {
            return nil
        }
        return url
    }


    func getFriends(complition: @escaping(Result<[User], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: version),
            //URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "nickname, photo_200_orig")
        ]
        guard let url = urlComponents.url else { return }

        network.sendRequest(url: url, complition: complition)
    }


    func getUserPhotos(userId: Int, complition: @escaping(Result<[Photo], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "owner_id", value: String(userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "photo_sizes", value: "1")
        ]
        guard let url = urlComponents.url else { return }

        network.sendRequest(url: url, complition: complition)
    }


    func getUserGroups(complition: @escaping(Result<[Group], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "user_id", value: Session.shared.userId),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "fields", value: "id, name, photo_200, description, fixed_post, site")
        ]
        guard let url = urlComponents.url else { return }

        network.sendRequest(url: url, complition: complition)
    }

// ???????????? ?????? ???????????????? ?????????? ??????????
    func getGroupSearch(complition: @escaping(Result<[Group], Error>) -> Void) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "owner_id", value: Session.shared.userId),
            URLQueryItem(name: "v", value: version),
            URLQueryItem(name: "q", value: String()),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "photo_sizes", value: "1")
        ]
        guard let url = urlComponents.url else { return }

        network.sendRequest(url: url, complition: complition)
    }

}
