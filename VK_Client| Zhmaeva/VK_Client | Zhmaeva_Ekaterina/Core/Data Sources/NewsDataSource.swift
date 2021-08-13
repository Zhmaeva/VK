//
//  NewsDataSource.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 02.07.2021.
//

import UIKit


var resultArray = [
    News(id: 0, avatar: UIImage(named: "1_1"), title: "Stanley Marsh", description: "Your friend Stan, shared a new photo", photo: UIImage(named: "1_2"), likes: 257, comments: 2),

    News(id: 1, avatar: UIImage(named: "3_2"), title: "Kenny McCormick", description: "Your friend Kenny, shared a new photo", photo: UIImage(named: "News_1"), likes: 53, comments: 67),

    News(id: 2, avatar: UIImage(named: "5_4"), title: "Leopold Stotch", description: "Your friend Butters, shared a new photo", photo: UIImage(named: "News_4"), likes: 400, comments: 9),

    News(id: 3, avatar: UIImage(named: "4_3"), title: "Eric Teodore Cartman", description: "Your friend Cartman, shared a new photo", photo: UIImage(named: "News_2"), likes: 13, comments: 17),

    News(id: 4, avatar: UIImage(named: "1_group"), title: "First group", description: "L👀k at this )", photo: UIImage(named: "News_3"), likes: 5, comments: 2),

    News(id: 5, avatar: UIImage(named: "1_group"), title: "First group", description: "Maybe I was on the trail of a new meme or something.", photo: UIImage(named: "News_5"), likes: 32, comments: 67),

    News(id: 6, avatar: UIImage(named: "4_group"), title: "Fourth group", description: "To lighten the mood 😁)", photo: UIImage(named: "News_6"), likes: 367, comments: 1),

    News(id: 7, avatar: UIImage(named: "3_group"), title: "Third group", description: "New meme 🔥", photo: UIImage(named: "News_7"), likes: 1, comments: 23),

    News(id: 8, avatar: UIImage(named: "4_group"), title: "Fourth group", description: "Just like genes, memes replicate, mutate and adapt.", photo: UIImage(named: "News_8"), likes: 78, comments: 5)
]



func getNews() -> [News] {
    return resultArray
}

func updateNews(news: News) -> [News] {
    resultArray[news.id] = news
    
    return resultArray
}

