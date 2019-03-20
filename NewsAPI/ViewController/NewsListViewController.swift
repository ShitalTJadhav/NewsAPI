//
//  NewsListViewController.swift
//  NewsAPI
//
//  Created by Tushar  Jadhav on 2019-03-20.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    
    private var feedService: FeedsService!
    private var viewModel: NewsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "News"
        
        feedService = FeedsService(networking: NetworkService.shared)
        self.viewModel = NewsListViewModel(service: feedService)
        
        //Set up indicator
        setUpIndicatorView()
        
        //Set table view
        setUpTableView()
        
        //Fetch All news data list from server
        self.loadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Setup / Private methods

    private func loadData() {
        
        viewModel.loadNewsData({[unowned self] result in
            self.indicatorView.stopAnimating()
            
            switch result {
            case .failure(let error):
                self.showAlertWithMessage(message: error.reason)
            case .success(_):
                DispatchQueue.main.async {
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    fileprivate func setUpIndicatorView() {
        
        //Set Indicator setting
        indicatorView.color = UIColor.gray
        indicatorView.hidesWhenStopped = true
        indicatorView.accessibilityIdentifier = "NewsList_IndicatioView"
        indicatorView.startAnimating()
    }
    
    fileprivate func setUpTableView() {
        
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.accessibilityIdentifier = "NewsListTableViewIdentifier"
    }
}

// MARK: - UITableViewDataSource

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalNewsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! NewsCustomCell
        cell.tag = indexPath.row
        
        //Grab the data from datasource
        let model = self.viewModel.articel(at: indexPath.row)
        
        //Update cell using the data model
        cell.model = model
        
        return cell
    }

}

