//
//  News.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 02.07.2021.
//


import UIKit


struct News {
    let id: Int
    let avatar: UIImage!
    let title: String!
    let description: String
    let photo: UIImage!
    var likes: Int
    let comments: Int
    var hasMyLike: Bool
    
    init(id: Int, avatar: UIImage?, title: String?, description: String, photo: UIImage?, likes: Int, comments: Int) {
        self.id = id
        self.avatar = avatar
        self.title = title
        self.description = description
        self.photo = photo
        self.likes = likes
        self.comments = comments
        self.hasMyLike = false
    }
    
    mutating func like() {
        self.hasMyLike = true
        self.likes+=1
    }
    
    mutating func dislike() {
        self.hasMyLike = false
        self.likes-=1
    }
}

