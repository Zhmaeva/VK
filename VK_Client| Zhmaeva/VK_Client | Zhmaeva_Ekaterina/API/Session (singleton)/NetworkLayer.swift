//
//  NetworkLayer.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 10.08.2021.
//

import Foundation

final class NetworkLayer {

    func getAuthUrl() -> URL? {

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7923746"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "scope", value: "offline"),
            URLQueryItem(name: "response_type", value: "token")

        ]
        guard let url = urlComponents.url else {
            return nil
        }

        return url
    }
}
