//
//  NewsDetailViewController.swift
//  NewsAPI
//
//  Created by Tushar  Jadhav on 2019-03-20.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Details"
        tableView.dataSource = self
    }

}

// MARK: - UITableViewDataSource

extension NewsDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! NewsDetailsCustomCell
        cell.tag = indexPath.row
        
        //Update cell using the data model
        cell.model = article
        
        return cell
    }
    
}
