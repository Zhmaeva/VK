//
//  Person.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 24.06.2021.
//

import Foundation

// MARK: - User

struct User: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo200Orig: String
}
