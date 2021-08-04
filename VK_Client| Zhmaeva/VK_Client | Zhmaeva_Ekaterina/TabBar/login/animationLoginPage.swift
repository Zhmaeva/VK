//
//  animationLoginPage.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 11.07.2021.
//

import UIKit


extension LoginViewController {
    
    // MARK: - Animation
    
    func animateTitleLabel() {
        titleLabel.transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height / 1)
        
        UIView.animate(withDuration: 1.2,
                       delay: 1,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: { [weak self] in
                        guard let self = self else {return}
                        self.titleLabel.transform = .identity
                       },
                       completion: nil)
    }
    
    func gradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.blue.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0 as NSNumber, 3 as NSNumber]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.opacity = 90
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)

    }
    
    func animateLoginPasswordTextField() {
        loginTextField.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        passwordTextField.transform = CGAffineTransform(translationX: -view.bounds.width, y: 0)
        
        UIView.animate(withDuration: 1,
                       delay: 2,
                       options: .curveLinear,
                       animations: { [weak self] in
                        guard let self = self else {return}
                        self.loginTextField.transform = .identity
                        self.passwordTextField.transform = .identity
                       },
                       completion: nil)
    }
    
    func animateIcon() {
        let animation = CABasicAnimation(keyPath: "opacity")
        
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 2
        animation.fillMode = CAMediaTimingFillMode.backwards
        titleImageView.layer.add(animation, forKey: nil)
        
    }
    
    func animateButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 250
        animation.mass = 1.5
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.loginButton.layer.add(animation, forKey: nil)
    }
    
    func startFakeNetworkCall() {
        loginButton.isHidden = true
        backViewCircle.isHidden = false
        
        UIView.animateKeyframes(withDuration: 5.0,
                                delay: 0,
                                options: [.calculationModeCubic],
                                animations: { [weak self] in
                                    guard let self = self else {return}
                                    // Add animations
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 1.0/6.0,
                                                       animations: {
                                                        self.circleOne.alpha = 1
                                                        self.circleTwo.alpha = 0
                                                        self.circleThree.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 1.0/6.0,
                                                       relativeDuration: 1.0/5.0,
                                                       animations: {
                                                        self.circleOne.alpha = 0
                                                        self.circleTwo.alpha = 1
                                                        self.circleThree.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 2.0/6.0,
                                                       relativeDuration: 1.0/5.0,
                                                       animations: {
                                                        self.circleOne.alpha = 0
                                                        self.circleTwo.alpha = 0
                                                        self.circleThree.alpha = 1
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 3.0/6.0,
                                                       relativeDuration: 1.0/5.0,
                                                       animations: {
                                                        self.circleOne.alpha = 1
                                                        self.circleTwo.alpha = 0
                                                        self.circleThree.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 4.0/6.0,
                                                       relativeDuration: 1.0/5.0,
                                                       animations: {
                                                        self.circleOne.alpha = 0
                                                        self.circleTwo.alpha = 1
                                                        self.circleThree.alpha = 0
                                                       })
                                    UIView.addKeyframe(withRelativeStartTime: 5.0/6.0,
                                                       relativeDuration: 1.0/5.0,
                                                       animations: {
                                                        self.circleOne.alpha = 0
                                                        self.circleTwo.alpha = 0
                                                        self.circleThree.alpha = 1
                                                       })
                                    self.circleOne.layer.removeAllAnimations()
                                    self.circleTwo.layer.removeAllAnimations()
                                    self.circleThree.layer.removeAllAnimations()
                                },
                                completion: { [weak self]_ in
                                    guard let self = self else {return}
                                    self.performSegue(withIdentifier: self.toTabBarSegueIdentifier,
                                                 sender: nil)
                                    
                                })
    }
}

