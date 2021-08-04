//
//  animationHomeTableView.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 18.07.2021.
//

import UIKit

extension HomeTableViewCell {
    
    func animateHeart() {

        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.damping = 75
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.stiffness = 75
        animation.mass = 1.5
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.heartRed.layer.add(animation, forKey: nil)
        self.backViewHeart.layer.add(animation, forKey: nil)
        
    }
}
