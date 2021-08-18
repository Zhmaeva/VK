//
//  GalleryViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 12.07.2021.
//

import UIKit

final class GalleryViewController: UIViewController {

    @IBOutlet weak var backViewGallery: UIView!
    @IBOutlet weak var backgroundGallery: UIImageView!
    @IBOutlet weak var fullPhoto: UIImageView!

    let network = NetworkLayer()
    var gallery = [Photo]()

    var currentIndex = 0
    var currentPhoto: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCurrentPhoto()
        swipePhotos()
        
    }


    func getPhotoMaxSizeUrl(photo: Photo) -> String {
        var maxSize = photo.sizes[0]
        for item in photo.sizes {
            if item.width > maxSize.width {
                maxSize = item
            }
        }

        return maxSize.url
    }

    func createPhoto() -> UIImageView? {
        guard currentIndex < gallery.count else {return nil}
        guard currentIndex >= 0 else {return nil}
        let photoView = UIImageView()
        photoView.frame = UIScreen.main.bounds
        photoView.backgroundColor = .black
        photoView.contentMode = .scaleAspectFit
        photoView.isUserInteractionEnabled = true

        let photoMaxSizeUrl = getPhotoMaxSizeUrl(photo: gallery[currentIndex])

        network.getImage(imageUrl: photoMaxSizeUrl) { [weak photoView] result in
            guard let photoView = photoView else { return }
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        photoView.image = UIImage(data: image)
                    }
            }
        }

        return photoView
    }

    func showCurrentPhoto() {
        if let newPhoto = createPhoto() {
            currentPhoto = newPhoto
            showPhoto(newPhoto)
        } else {
            currentIndex = 0
            return
        }
    }

    func showPhoto(_ photoView: UIImageView) {
        self.view.addSubview(photoView)
        
        UIView.animate(withDuration: 0.4) {
            photoView.center = self.view.center
        }
    }

    func swipePhotos() {
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                  action: #selector(self.showNextPhoto))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(self.showNextPhoto))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }

    func swipeLeft() {
        if let newPhoto = createPhoto() {
            currentPhoto = newPhoto
            showPhoto(newPhoto)
            let nextIndex = currentIndex + 1
            if nextIndex < gallery.count {
                currentIndex = nextIndex
            } else { return }
        }
    }

    func swipeRight() {
        if let newPhoto = createPhoto() {
            currentPhoto = newPhoto
            showPhoto(newPhoto)
            let nextIndex = currentIndex - 1
            if nextIndex < gallery.count {
                currentIndex = nextIndex
            } else { return }
        }
    }

    @objc func showNextPhoto(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
                case UISwipeGestureRecognizer.Direction.left:
                    swipeLeft()
                case UISwipeGestureRecognizer.Direction.right:
                   swipeRight()
                default:
                    break
            }
        }
    }
}
