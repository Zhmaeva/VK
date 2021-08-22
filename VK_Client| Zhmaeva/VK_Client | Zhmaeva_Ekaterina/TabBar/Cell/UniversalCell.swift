//
//  UniversalCell.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 25.06.2021.
//

import UIKit

// MARK: - Universal cell for friends and groups

final class UniversalCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

// MARK: - Public property

    var savedAnyObject: Any?
    let network = NetworkLayer()

// MARK: - Private methods

    private func setup() {
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


    private func clearCell() {
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

// MARK: Configure cell

    func configure(title: String?, image: UIImage?) {
        titleLabel.text = title
        pictureImageView.image = image
    }


    func configure(user: UserRealm) {
        gradientView()
        savedAnyObject = user
        titleLabel.text = "\(user.firstName) \(user.lastName)"

        network.getImage(imageUrl: user.photo) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        self.pictureImageView.image = UIImage(data: image)
                    }
            }
        }
    }


    func configure(group: Group) {
        gradientView()
        savedAnyObject = group
        titleLabel.text = group.name
        network.getImage(imageUrl: group.photo200) { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        self.pictureImageView.image = UIImage(data: image)
                    }
            }
        }
    }
    
}
