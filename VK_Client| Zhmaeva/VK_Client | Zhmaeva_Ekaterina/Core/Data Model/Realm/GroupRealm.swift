//
//  GroupRealm.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 22.08.2021.
//

import Foundation
import RealmSwift

final class GroupRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = String()
    @objc dynamic var photo = String()

    convenience init(id: Int,
                     name: String,
                     photo: String) {
        self.init()

        self.id = id
        self.name = name
        self.photo = photo
    }


    override static func primaryKey() -> String? {
        return "id"
    }


}
