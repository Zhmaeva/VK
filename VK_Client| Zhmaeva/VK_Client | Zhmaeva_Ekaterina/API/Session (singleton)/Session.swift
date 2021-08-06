//
//  Session.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 06.08.2021.
//

import Foundation

final class Session {

    static let instance = Session()

    var token: String = ""
    var userId: Int = 0

    private init() {}
}

