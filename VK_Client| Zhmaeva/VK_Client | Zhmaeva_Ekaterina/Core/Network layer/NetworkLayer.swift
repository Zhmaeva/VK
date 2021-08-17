//
//  NetworkLayer.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 11.08.2021.
//

import Foundation

final class NetworkLayer {
    func getImage(imageUrl: String, complition: @escaping(Result<Data, Error>) -> Void) {
        guard let url = URL(string: imageUrl) else { return }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error  in
            if let error = error {
                complition(.failure(error))
            }

            if let data = data {
                complition(.success(data))
            }
        }
        dataTask.resume()
    }
}

