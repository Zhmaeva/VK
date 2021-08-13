//
//  Session.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 06.08.2021.
//

import Foundation

final class Session {

    public static let shared = Session()

    var token: String = String()
    var userId: String = String()

    private init() {}
}

