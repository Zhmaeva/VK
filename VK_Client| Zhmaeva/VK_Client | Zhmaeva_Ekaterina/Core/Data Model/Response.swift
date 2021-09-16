//
//  Response.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 17.08.2021.
//

import Foundation

// MARK: - Response

struct Response<T: Decodable>: Decodable {
    let response: ResponseWrapper<T>
}

struct ResponseWrapper<T: Decodable>: Decodable {
    let items: [T]
    let profiles: [T]?
    let groups: [T]?
}

