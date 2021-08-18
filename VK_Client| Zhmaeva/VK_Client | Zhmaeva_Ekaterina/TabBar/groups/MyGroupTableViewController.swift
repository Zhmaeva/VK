//
//  MyGroupTableViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 27.06.2021.
//

import UIKit

class MyGroupTableViewController: UITableViewController {
    
    private let reuseIdentifierUniversalCell = "reuseIdentifierUniversalCell"
    private let reuseIdentifierMyGroupsTableCell = "reuseIdentifierMyGroupsTableCell"
    
    var myGroupArray = [Group]()
    
    // обновление ячеек перед появлением
    override func viewWillAppear(_ animated: Bool) {
        tableView.backgroundColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979321122, alpha: 1)
        self.tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "UniversalCell", bundle: nil), forCellReuseIdentifier: reuseIdentifierUniversalCell)
        
        NotificationCenter.default.addObserver(self, selector: #selector(addNewGroup(_:)), name: NSNotification.Name(rawValue: "sendGroup"), object: nil)
    }
    
    // проверяем содержится ли группа в массиве
    func isContainedAnArray(group: Group) -> Bool {
        if myGroupArray.contains(where: { itemGroup in itemGroup.name == group.name }) {
            return true
        }
        return false
    }
    
    @objc func addNewGroup(_ notification: Notification) {
        guard let newGroup = notification.object as? Group else {return}
        
        if isContainedAnArray(group: newGroup) {
            return
        }
        
        myGroupArray.append(newGroup)
        self.tableView.reloadData()
    }

    
    // удаление добавленных групп
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        myGroupArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroupArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierUniversalCell, for: indexPath) as? UniversalCell else {return UITableViewCell()}
        
        // Configure the cell
        cell.configure(group: myGroupArray[indexPath.row])
        
        return cell
    }

    // расстояние между ячейками
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // убираем лишние незаполненые ячейки
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
