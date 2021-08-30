//
//  DataManager.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 22.08.2021.
//

import Foundation
import RealmSwift


final class DataManager {

    // MARK: - Private propertys

    private let client = VkClient()
    private let expirationTime = 10.0
    private var friedsLastRequestTime: Date? = nil
    private var groupsLastRequestTime: Date? = nil

    //MARK: - Public methods

    func getFriends(complition: @escaping(Result<[UserRealm], Error>) -> Void) {
        if friedsLastRequestTime != nil && friedsLastRequestTime!.addingTimeInterval(expirationTime * 60) > Date() {
            guard let realm = try? Realm() else { return }
            let friends = realm.objects(UserRealm.self)
            let friendsArray = Array(friends)

            complition(.success(friendsArray))
            return
        }

        client.getFriends { [weak self] result in
            guard let self = self else { return }

            guard case let Result.success(data) = result else {
                if case let Result.failure(err) = result {
                    complition(.failure(err))
                }
                return
            }

            let users = data.map { user -> UserRealm in
                let userRealm = UserRealm(id: user.id, firstName: user.firstName, lastName: user.lastName, photo: user.photo200Orig, photos: [])
                return userRealm
            }

            DispatchQueue.main.async  {
                guard let realm = try? Realm() else { return }

                try? realm.write {
                    realm.add(users, update: .modified)
                }

                self.friedsLastRequestTime = Date()

                complition(.success(users))
            }
        }
    }

    func getUserPhotos(userId: Int, complition: @escaping(Result<[PhotoRealm], Error>) -> Void) {
        client.getUserPhotos(userId: userId) { result in
            switch result {
                case.failure(let error):
                    complition(.failure(error))
                case.success(let photos):
                    let photosRealm = photos.map { photo -> PhotoRealm in
                        let sizes = photo.sizes.map { size -> PhotoSizesRealm in
                            let sizeRealm = PhotoSizesRealm(height: size.height, width: size.width, url: size.url)
                            return sizeRealm
                        }

                        let photoRealm = PhotoRealm(id: photo.id, sizes: sizes)
                        return photoRealm
                    }

                    DispatchQueue.main.async {
                        guard let realm = try? Realm() else { return }

                        try? realm.write{
                            realm.add(photosRealm, update: .modified)
                        }

                        complition(.success(photosRealm))
                    }
            }
        }
    }


    func getUserGroups(complition: @escaping(Result<[GroupRealm], Error>) -> Void) {
        if groupsLastRequestTime != nil && groupsLastRequestTime!.addingTimeInterval(expirationTime * 60) > Date() {
            guard let realm = try? Realm() else { return }

            let groups = realm.objects(GroupRealm.self)
            let groupsArray = Array(groups)

            complition(.success(groupsArray))
            return
        }

        client.getUserGroups { [weak self] result in
            guard let self = self else { return }

            guard case let Result.success(data) = result else {
                if case let Result.failure(error) = result {
                    complition(.failure(error))
                }
                return
            }
            let groups = data.map { group -> GroupRealm in
                let groupRealm = GroupRealm(id: group.id, name: group.name, photo: group.photo200)
                return groupRealm
            }

            DispatchQueue.main.async  {
                guard let realm = try? Realm() else { return }

                try? realm.write {
                    realm.add(groups, update: .modified)
                }

                self.groupsLastRequestTime = Date()

                complition(.success(groups))
            }
        }
    }
}
