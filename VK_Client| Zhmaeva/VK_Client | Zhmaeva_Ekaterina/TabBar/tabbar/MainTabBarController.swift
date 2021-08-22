//
//  MainTabBarController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 26.06.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    
    // MARK: - Create User data source array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let friendsNavigationController = self.viewControllers?.first as? UINavigationController,
           let friendViewController = friendsNavigationController.viewControllers.first as? AllFriendsViewController {
            friendViewController.configure()
        }
    }
}
