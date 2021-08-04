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


    func configure(image: UIImage) {
        photoImageView.image = image
    }
}
