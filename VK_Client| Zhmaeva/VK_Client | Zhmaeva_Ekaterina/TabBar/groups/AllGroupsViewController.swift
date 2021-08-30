//
//  AllGroupsViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 01.07.2021.
//

import UIKit

//MARK: - AllGroupsViewController

final class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var allGroupTableView: UITableView!
    @IBOutlet weak var searchBarAllGroups: UISearchBar!

    // MARK: Private propertys

    private let reuseIdentifierUniversalCell = "reuseIdentifierUniversalCell"
    
    private var allGroupArray = [GroupRealm]()
    private var searchGroupArray = [GroupRealm]()
    private let groupsClient = DataManager()

    // MARK: Private methods

    private func loadGroups() {
        groupsClient.getUserGroups { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let groups):
                    self.allGroupArray = groups
                    self.searchGroupArray = groups
                    DispatchQueue.main.async {
                        self.allGroupTableView.reloadData()
                    }
            }
        }
    }

/*
написать поиск по группам

     private func loadGroupsSearch() {
        groupsApiClient.getGroupSearch { [weak self] result in
            guard let self = self else { return }
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let groups):
                    self.allGroupArray = groups
                    self.searchGroupArray = groups
                    DispatchQueue.main.async {
                        self.allGroupTableView.reloadData()
                    }
            }
        }
    }
*/


    // MARK: - Life circle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allGroupTableView.backgroundColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.allGroupTableView.register(UINib(nibName: "UniversalCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalCell)

        allGroupTableView.delegate = self
        allGroupTableView.dataSource = self
        searchBarAllGroups.delegate = self

        loadGroups()
    }

}

// MARK: - Table view data source

extension AllGroupsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalCell, for: indexPath) as? UniversalCell else {return UITableViewCell()}

        cell.configure(group: searchGroupArray[indexPath.row])
        
        return cell
    }

}

// MARK: - Table view data delegate

extension AllGroupsViewController:  UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // переход по нажатии на ячейку

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalCell,
              let cellObject = cell.savedAnyObject as? GroupRealm
        else {return}

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendGroup"), object: cellObject)

        self.navigationController?.popViewController(animated: true)
    }

}


// MARK: - UISearchBarDelegate

extension AllGroupsViewController: UISearchBarDelegate  {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchGroupArray = allGroupArray
        } else {
            searchGroupArray = allGroupArray.filter({ groupItem in
                groupItem.name.lowercased().contains(searchText.lowercased())
            })
        }
        allGroupTableView.reloadData()
    }

}
