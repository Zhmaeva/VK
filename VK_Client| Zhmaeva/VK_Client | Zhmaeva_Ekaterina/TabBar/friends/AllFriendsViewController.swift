//
//  AllFriendsViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 25.06.2021.
//

import UIKit

class AllFriendsViewController: UIViewController {

    @IBOutlet weak var myFriendsTableView: UITableView!
    @IBOutlet weak var searchFriends: UISearchBar!

    
    let reuseIdentifierUniversalCell = "reuseIdentifierUniversalCell"
    let segueFromFriendsToPhoto = "fromFriendsTableViewToPhotoFriendsCollectionViewSegue"
    
    var personsArray = [Person]()
    var searchResultArray = [Person]()
    
    func configure(personsArray: [Person]) {
        self.personsArray = personsArray
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myFriendsTableView.backgroundColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
        myFriendsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myFriendsTableView.register(UINib(nibName: "UniversalCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalCell)
        
        myFriendsTableView.delegate = self
        myFriendsTableView.dataSource = self
        searchFriends.delegate = self
        searchResultArray = personsArray
    }
}


extension AllFriendsViewController: UISearchBarDelegate  {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResultArray = personsArray
        } else {
            searchResultArray = personsArray.filter({ personItem in
                personItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        myFriendsTableView.reloadData()
    }

    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // реализовать скрытие клавиатуры
        
    }
}


extension AllFriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayLetter().count
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayByLetter(letter: arrayLetter()[section]).count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myFriendsTableView.dequeueReusableCell(withIdentifier: "reuseIdentifierUniversalCell", for: indexPath) as? UniversalCell else {return UITableViewCell()}
        
        let arrayByLetterItems = arrayByLetter(letter: arrayLetter()[indexPath.section])
        cell.configure(user: arrayByLetterItems[indexPath.row])
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueFromFriendsToPhoto,
            let dst = segue.destination as? PhotoCollectionViewController,
            let user = sender as? Person {
            dst.photoArray = user.photoArray
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalCell,
              let cellObject = cell.savedAnyObject as? Person
        else {return}
        
        performSegue(withIdentifier: segueFromFriendsToPhoto, sender: cellObject)
    }
    
// MARK: - Header
    
    func arrayLetter() -> [String] {
        var resultArray = [String]()
        
        for item in searchResultArray {
            let nameLetter = String(item.name.prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }
        return resultArray
    }
    
    func arrayByLetter(letter: String) -> [Person] {
        var resultArray = [Person]()
        
        for item in searchResultArray {
            let nameLetter = String(item.name.prefix(1))
            if nameLetter == letter {
                resultArray.append(item)
            }
        }
        return resultArray
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return arrayLetter()[section].uppercased()
    }
}