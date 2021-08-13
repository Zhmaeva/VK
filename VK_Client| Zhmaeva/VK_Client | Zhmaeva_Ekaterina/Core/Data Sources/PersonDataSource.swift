//
//  PersonDataSource.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 26.06.2021.
//

import Foundation
import UIKit

var namesFriends = [
    
    "Stanley Marsh",
    "Kyle Broflovski",
    "Kenny McCormick",
    "Eric Theodore Cartman",
    "Leopold Stotch Butters"
]

var stan = [
    
    UIImage(named: "1_1")!,
    UIImage(named: "1_2")!,
    UIImage(named: "1_3")!,
    UIImage(named: "1_4")!
]

var kyle = [
    
    UIImage(named: "2_1")!,
    UIImage(named: "2_2")!,
    UIImage(named: "2_3")!,
]

var kenny = [
    
    UIImage(named: "3_1")!,
    UIImage(named: "3_2")!,
    UIImage(named: "3_3")!,
    UIImage(named: "3_4")!
]

var cartman = [
    
    UIImage(named: "4_1")!,
    UIImage(named: "4_2")!,
    UIImage(named: "4_3")!,
    UIImage(named: "4_4")!,
    UIImage(named: "4_5")!
]

var butters = [
    
    UIImage(named: "5_1")!,
    UIImage(named: "5_2")!,
    UIImage(named: "5_3")!,
    UIImage(named: "5_4")!,
    UIImage(named: "5_5")!
]

func setupUser() -> [Person] {
    
    var resultArray = [Person]()
    
    let userStan = Person(name: "Stanley Marsh", photo: UIImage(named: "1_4")!, photoArray: stan)
    resultArray.append(userStan)
    
    let userKyle = Person(name: "Kyle Broflovski", photo: UIImage(named: "2_3")!, photoArray: kyle)
    resultArray.append(userKyle)
    
    let userKenny = Person(name: "Kenny McCormick", photo: UIImage(named: "3_2")!, photoArray: kenny)
    resultArray.append(userKenny)
    
    let userCartman = Person(name: "Eric Theodore Cartman", photo: UIImage(named: "4_1")!, photoArray: cartman)
    resultArray.append(userCartman)
    
    let userButters = Person(name: "Leopold Stotch Butters", photo: UIImage(named: "5_5")!, photoArray: butters)
    resultArray.append(userButters)
    
    return resultArray
}
