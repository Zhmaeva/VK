//
//  UniversalCell.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 25.06.2021.
//

import UIKit

class UniversalCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!


    var savedAnyObject: Any?


    func setup() {
        pictureImageView.layer.cornerRadius = 22
        backView.layer.cornerRadius = 22
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOpacity = 0.3
        backView.layer.shadowOffset = CGSize(width: 5, height: 5)
        backView.layer.shadowRadius = 2
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOpacity = 0.3
        titleLabel.layer.shadowOffset = CGSize(width: 10, height: 10)
        titleLabel.layer.shadowRadius = 3
        animateAvatar()
        
    }


    func clearCell() {
        self.pictureImageView.image = nil
        self.titleLabel.text = nil
        savedAnyObject = nil
    }


    override func prepareForReuse() {
        clearCell()
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }


    func configure(title: String?, image: UIImage?) {
        titleLabel.text = title
        pictureImageView.image = image
    }


    func configure(user: Person) {
        gradientView()
        savedAnyObject = user
        titleLabel.text = user.name
        pictureImageView.image = user.photo
    }


    func configure(group: Group) {
        gradientView()
        savedAnyObject = group
        titleLabel.text = group.header
        pictureImageView.image = group.icon   }
    
}

