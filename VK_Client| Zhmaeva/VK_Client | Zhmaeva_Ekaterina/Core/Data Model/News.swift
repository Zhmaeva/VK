//
//  News.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 02.07.2021.
//


import UIKit


struct News: Decodable {
    let source_id: Int
    let date: Int
    let type: String
    let post_type: String
    let post_id: Int
    let text: String
    let attachments: [Attachments]?
    let photos: [Photos]?
    let post_source: [PostSource]
    let comments: [Comments]
    let likes: [Likes]
    let views: [Views]
}

struct Attachments: Decodable {
    let type: String
    let photo: [Photo]
}

struct Photos: Decodable {
    let items: [Photo]
}

struct PostSource: Decodable {
    let type: String
}

struct Comments: Decodable {
    let count: Int
    let can_post: Int
}

struct Likes: Decodable {
    let count: Int
    let user_likes: Int
    let can_like: Int
    let can_publish: Int
}

struct Views: Decodable {
    let count: Int
}
