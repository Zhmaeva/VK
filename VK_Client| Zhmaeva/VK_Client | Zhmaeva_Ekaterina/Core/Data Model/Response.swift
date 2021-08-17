//
//  Response.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 17.08.2021.
//

import Foundation

struct ResponseWrapper<T: Decodable>: Decodable {
    let items: [T]
}

struct Response<T: Decodable>: Decodable {
    let response: ResponseWrapper<T>
}
