//
//  HomeTableViewCell.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 01.07.2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var backViewPhoto: UIView!
    @IBOutlet weak var photoFriendsAndGroups: UIImageView!
    @IBOutlet weak var backViewLabel: UIView!
    @IBOutlet weak var titleOrName: UILabel!
    @IBOutlet weak var descriptionNews: UILabel!
    @IBOutlet weak var backViewFullPhoto: UIView!
    @IBOutlet weak var fullPhotoFriendOrGroup: UIImageView!
    @IBOutlet weak var backViewLikeBar: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var backViewHeart: UIView!
    @IBOutlet weak var heartRed: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var backViewComments: UIView!
    @IBOutlet weak var commentsImage: UIImageView!
    @IBOutlet weak var commentsCount: UILabel!

    let network = NetworkLayer()

    func setup() {
        backViewPhoto.layer.cornerRadius = 50
        photoFriendsAndGroups.layer.cornerRadius = 50
    }


    func clearCell() {
        photoFriendsAndGroups.image = nil
        titleOrName.text = nil
        descriptionNews.text = nil
        fullPhotoFriendOrGroup.image = nil
        heartRed.image = nil
        likeCount.text = nil
        commentsCount.text = nil
    }


    override func prepareForReuse() {
        clearCell()
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        clearCell()
    }

    
    func configure(news: News) {
        titleOrName.text = news.text

    }
    
    
    @IBAction func clickLikeButton(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
