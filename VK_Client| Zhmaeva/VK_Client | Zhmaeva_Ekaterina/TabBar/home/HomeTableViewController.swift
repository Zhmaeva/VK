//
//  HomeTableViewController.swift
//  VK_Client | Zhmaeva_Ekaterina
//
//  Created by Catherine on 01.07.2021.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    
    @IBOutlet var newsTableView: UITableView!
    
    
    let reuseIdentifierHomeTableViewController = "reuseIdentifierHomeTableViewController"
    
    var news = [News]()
    
    func onUpdateNews(news: News) {
        self.news = updateNews(news: news)
        view.backgroundColor = #colorLiteral(red: 0.771590054, green: 0.7699093819, blue: 0.9986669421, alpha: 1)
        newsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.news = getNews()
        
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsTableView.dequeueReusableCell(withIdentifier: "reuseIdentifierHomeTableViewController", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}
        
        // Configure the cell
        cell.configure(news: news[indexPath.item], onUpdate: self.onUpdateNews)
        
        return cell
    }
}
