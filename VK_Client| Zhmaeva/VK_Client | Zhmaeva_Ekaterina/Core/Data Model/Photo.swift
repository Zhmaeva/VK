//
//  Photo.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 17.08.2021.
//

import Foundation

// MARK: - Photo

struct Photo: Decodable {
    let id: Int
    let sizes: [Size]
}

struct Size: Decodable {
    let height: Int
    let width: Int
    let url: String
}
