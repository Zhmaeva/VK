//
//  AllFriendsViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 25.06.2021.
//

import UIKit
import RealmSwift
// MARK: - AllFriendsViewController

final class AllFriendsViewController: UIViewController {

    @IBOutlet weak var myFriendsTableView: UITableView!
    @IBOutlet weak var searchFriends: UISearchBar!

    // MARK: - Public propertys

    var personsArray = [UserRealm]()
    var searchResultArray = [UserRealm]()
    var token: NotificationToken?

    // MARK: - Private propertys

    private let reuseIdentifierUniversalCell = "reuseIdentifierUniversalCell"
    private let segueFromFriendsToPhoto = "fromFriendsTableViewToPhotoFriendsCollectionViewSegue"
    private let dataManger = DataManager()

    // MARK: - Public methods

    func realmNotifications() {
        let realm = try! Realm()
        let friends = realm.objects(UserRealm.self)
        token = friends.observe{ changes in
            switch changes {
                case .initial(let results):
                    print(results)
                case let .update(results, deletions, insertions, modifications):
                    print(results, "The object was deleted \(deletions)", insertions, modifications)
                case .error(let error):
                    print("An error occurred: \(error).")
            }
            print("Данные изменились")
        }
    }

    func configure() {
    }


    func loadData() {
        dataManger.getFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let users):
                    self.personsArray = users
                    self.searchResultArray = users
                    DispatchQueue.main.async {
                        self.myFriendsTableView.reloadData()
                    }
            }
        }
    }

    // MARK: - Life circle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.myFriendsTableView.register(UINib(nibName: "UniversalCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalCell)
        
        myFriendsTableView.delegate = self
        myFriendsTableView.dataSource = self
        searchFriends.delegate = self

        loadData()
        realmNotifications()

    }
}

// MARK: - UISearchBarDelegate

extension AllFriendsViewController: UISearchBarDelegate  {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchResultArray = personsArray
        } else {
            searchResultArray = personsArray.filter({ personItem in
                ((personItem.firstName) + (personItem.lastName)).lowercased().contains(searchText.lowercased())
            })
        }
        myFriendsTableView.reloadData()
    }
}


// MARK: - UITableViewDelegate and UITableViewDataSource

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
           let user = sender as? UserRealm {
            dst.userId = user.id
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalCell,
              let cellObject = cell.savedAnyObject as? UserRealm
        else {return}
        
        performSegue(withIdentifier: segueFromFriendsToPhoto, sender: cellObject)
    }
    
    // MARK: - Header for cell
    
    func arrayLetter() -> [String] {
        var resultArray = [String]()
        
        for item in searchResultArray {
            let fullName = item.firstName + item.lastName
            let nameLetter = String(fullName.prefix(1))
            if !resultArray.contains(nameLetter) {
                resultArray.append(nameLetter)
            }
        }

        resultArray.sort()

        return resultArray
    }
    
    func arrayByLetter(letter: String) -> [UserRealm] {
        var resultArray = [UserRealm]()
        
        for item in searchResultArray {
            let fullName = item.firstName + item.lastName
            let nameLetter = String(fullName.prefix(1))
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
