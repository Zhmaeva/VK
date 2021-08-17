//
//  PhotoCell.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 26.06.2021.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    private let network = NetworkLayer()
    
    func setup() {
        
    }
    
    
    func clearCell() {
        photoImageView.image = nil
    }
    
    
    override func prepareForReuse() {
        clearCell()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }
    
    
    func configure(image: Photo) {
        var sizes = image.sizes
        sizes.sort { a, b in
            return b.width - a.width > 0
        }

        let mediana = sizes.count / 2
        let photoUrl = sizes[mediana - 1].url

        network.getImage(imageUrl: photoUrl) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let photo):
                    DispatchQueue.main.async {
                        self.photoImageView.image = UIImage(data: photo)
                    }
            }
        }
    }
}
