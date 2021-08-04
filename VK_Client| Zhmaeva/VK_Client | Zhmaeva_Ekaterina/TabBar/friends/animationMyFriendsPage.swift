//
//  animationMyFriendsPage.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 12.07.2021.
//

import UIKit

extension UniversalCell {
    
    func animateAvatar() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        
        pictureImageView.addGestureRecognizer(tap)
        pictureImageView.isUserInteractionEnabled = true
        //self.pictureImageView.addSubview(pictureImageView)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.damping = 75
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.stiffness = 75
        animation.mass = 1.5
        animation.duration = 0.5
        animation.beginTime = CACurrentMediaTime() + 0.5
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.pictureImageView.layer.add(animation, forKey: nil)
        self.backView.layer.add(animation, forKey: nil)
    }
    
    func gradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0 as NSNumber, 3 as NSNumber]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.opacity = 90
        
        gradientLayer.frame = contentView.bounds
        contentView.layer.insertSublayer(gradientLayer, at: 0)

    }
}

// не знаю как кастомизировать хэдэр
extension HeaderView {
    func gradientHeaderView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0 as NSNumber, 3 as NSNumber]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.opacity = 90
        
        gradientLayer.frame = backViewHeader.bounds
        backViewHeader.layer.insertSublayer(gradientLayer, at: 0)

    }
}
