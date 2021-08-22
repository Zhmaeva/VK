//
//  PhotoSizesRealm.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 22.08.2021.
//

import Foundation
import RealmSwift

final class PhotoSizesRealm: Object {
    @objc dynamic var height = 0
    @objc dynamic var width = 0
    @objc dynamic var url = String()
    let photo = LinkingObjects(fromType: PhotoRealm.self, property: "sizes")

    convenience init(height: Int,
                     width: Int,
                     url: String) {
        self.init()

        self.height = height
        self.width = width
        self.url = url
    }

    override static func primaryKey() -> String? {
        return "url"
    }
}
