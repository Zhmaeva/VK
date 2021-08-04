//
//  GroupDataSource.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 26.06.2021.
//

import Foundation
import UIKit

var headersGroup = [
    
    "First group",
    "Second group",
    "Third group",
    "Fourth group",
    "Fifth group"
]


var iconGroups = [
    
    UIImage(named: "1_group"),
    UIImage(named: "2_group"),
    UIImage(named: "3_group"),
    UIImage(named: "4_group"),
    UIImage(named: "5_group")
]

func setupGroup() -> [Group] {
    
    var resultArray = [Group]()
    
    let firstGroup = Group(header: "First group", icon: UIImage(named: "1_group")!)
    resultArray.append(firstGroup)
    
    let secondGroup = Group(header: "Second group", icon: UIImage(named: "2_group")!)
    resultArray.append(secondGroup)
    
    let thirdGroup = Group(header: "Third group", icon: UIImage(named: "3_group")!)
    resultArray.append(thirdGroup)
    
    let fourthGroup = Group(header: "Fourth group", icon: UIImage(named: "4_group")!)
    resultArray.append(fourthGroup)
    
    let fifthGroup = Group(header: "Fifth group", icon: UIImage(named: "5_group")!)
    resultArray.append(fifthGroup)
    
    return resultArray
}
