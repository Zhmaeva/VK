//
//  GalleryViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 12.07.2021.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var backViewGallery: UIView!
    @IBOutlet weak var backgroundGallery: UIImageView!
    @IBOutlet weak var fullPhoto: UIImageView!
    
    
    var gallery = [UIImage]()
    
    var nextIndex = 0
    var currentPhoto: UIImageView?
    let originalSize: CGFloat = 400
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        showNextPhoto()
    }
        
    func showNextPhoto() {
        if let newPhoto = createPhoto() {
            currentPhoto = newPhoto
            showPhoto(newPhoto)
        } else {
            nextIndex = 0
            showNextPhoto()
        }
    }

    
    func createPhoto() -> UIImageView? {
        guard nextIndex < gallery.count else {return nil}
        let photoView = UIImageView(image: gallery[nextIndex])
        photoView.frame = CGRect(x: self.view.frame.width,
                                 y: self.view.center.y - (originalSize / 2),
                                 width: originalSize,
                                 height: originalSize)
        // shadow
        photoView.layer.shadowColor = UIColor.black.cgColor
        photoView.layer.shadowOpacity = 0
        photoView.layer.shadowOffset = .zero
        photoView.layer.shadowRadius = 10
        
        // frame
        photoView.layer.borderWidth = 2
        photoView.layer.borderColor = UIColor.darkGray.cgColor
        
        nextIndex += 1
        return photoView
    }
    
    func showPhoto(_ photoView: UIImageView) {
        self.view.addSubview(photoView)
        
        UIView.animate(withDuration: 0.4) {
            photoView.center = self.view.center
        }
    }


}
