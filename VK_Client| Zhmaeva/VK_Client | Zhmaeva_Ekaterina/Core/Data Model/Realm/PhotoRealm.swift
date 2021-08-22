//
//  PhotoRealm.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 22.08.2021.
//

import Foundation
import RealmSwift

final class PhotoRealm: Object {
    @objc dynamic var id = 0
    let sizes = List<PhotoSizesRealm>()
    let user = LinkingObjects(fromType: UserRealm.self, property: "photos")

    convenience init(id: Int,
                     sizes: [PhotoSizesRealm]) {
        self.init()

        self.id = id
        self.sizes.append(objectsIn: sizes)
    }

    override static func primaryKey() -> String? {
        return "id"
    }
}
