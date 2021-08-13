//
//  AllGroupsViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 01.07.2021.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var allGroupTableView: UITableView!
    @IBOutlet weak var searchBarAllGroups: UISearchBar!
    
    let reuseIdentifierUniversalCell = "reuseIdentifierUniversalCell"
    
    var allGroupArray = [Group]()
    var searchGroupArray = [Group]()
    private let groupsApiClient = VkClient()

    // MARK: - Create Group data source array
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        allGroupTableView.backgroundColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
        allGroupTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupsApiClient.getUserGroups()
        groupsApiClient.getGroupSearch()
        allGroupArray = setupGroup()
        
        self.allGroupTableView.register(UINib(nibName: "UniversalCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalCell)
        allGroupTableView.delegate = self
        allGroupTableView.dataSource = self
        searchBarAllGroups.delegate = self
        searchGroupArray = allGroupArray
    }
}

extension AllGroupsViewController: UISearchBarDelegate  {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchGroupArray = allGroupArray
        } else {
            searchGroupArray = allGroupArray.filter({ groupItem in
                groupItem.header.lowercased().contains(searchText.lowercased())
            })
        }
        allGroupTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // реализовать скрытие клавиатуры
        
    }
}
// MARK: - Table view data source

extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // переход по нажатии на ячейку
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? UniversalCell,
              let cellObject = cell.savedAnyObject as? Group
        else {return}
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "sendGroup"), object: cellObject)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
