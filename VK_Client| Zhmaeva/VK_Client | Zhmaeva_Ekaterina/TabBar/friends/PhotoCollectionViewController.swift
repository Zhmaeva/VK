//
//  PhotoCollectionViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 26.06.2021.
//

import UIKit

private let reuseIdentifier = "Cell"
private let reuseIdentifierPhotoCollectionCell = "reuseIdentifierPhotoCollectionCell"
private let segueToGallery = "fromCollectionPhotoToGallery"

class PhotoCollectionViewController: UICollectionViewController {
    
    var photoArray = [UIImage]()
    
    private let photosApiClient = VkClient()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.backgroundColor = #colorLiteral(red: 0.129396528, green: 0.1294215024, blue: 0.1293910444, alpha: 1)
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photosApiClient.getUserPhotos()

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToGallery,
           let dst = segue.destination as? GalleryViewController,
           let selectedPhoto = sender as? Int {
            dst.gallery = photoArray
            dst.currentIndex = selectedPhoto
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: segueToGallery, sender: indexPath.item)
    }

    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photoArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? PhotoCell else {return UICollectionViewCell()}
        
        cell.configure(image: photoArray[indexPath.item])
        
        return cell
    }
}


extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    // Меняем размер картинок в UICollectionView

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.collectionView.bounds.width / 2 - 50
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 25, left: 25, bottom: 0, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(25)
    }
}
