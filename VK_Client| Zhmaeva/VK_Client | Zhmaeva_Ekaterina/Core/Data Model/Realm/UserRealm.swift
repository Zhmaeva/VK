//
//  UserRealm.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 22.08.2021.
//

import Foundation
import RealmSwift

final class UserRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var firstName = String()
    @objc dynamic var lastName = String()
    @objc dynamic var photo = String()
    let photos = List<PhotoRealm>()

    convenience init(id: Int,
         firstName: String,
         lastName: String,
         photo: String,
         photos: [PhotoRealm]) {
        self.init()

        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.photos.append(objectsIn: photos)
    }


    override static func primaryKey() -> String? {
        return "id"
    }


}
