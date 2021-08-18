//
//  Group.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 24.06.2021.
//

import Foundation

struct Group: Decodable {
    let id: Int
    let name: String
    let screenName: String
    let type: String
    let photo200: String
}
