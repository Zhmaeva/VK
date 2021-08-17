//
//  Response.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 17.08.2021.
//

import Foundation

struct Response<T: Codable>: Codable {
    let response: T
}
