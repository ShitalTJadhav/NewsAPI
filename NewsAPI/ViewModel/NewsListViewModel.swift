//
//  NewsListViewModel.swift
//  NewsAPI
//
//  Created by Tushar  Jadhav on 2019-03-20.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import Foundation

class NewsListViewModel {
    
    weak var service: NewsService?
    var dataList: [Article] = []
    
    // date indicating from 'from' fetch all news
    var fromDate: String = ""
    
    // date indicating from 'to' fetch all news
    var toDate: String = ""
    
    init(service : NewsService) {
        self.service = service
        
        toDate = toDate.getCurrentDate()
//        fromDate = toDate
    }
    
    var totalNewsCount: Int {
        return dataList.count
    }
    
    func articel(at index: Int) -> Article {
        return dataList[index]
    }
    
    func loadNewsData(_ completion: @escaping (Result<[Article], DataResponseError>) -> Void) {
        
        guard let _ = service else {
            completion(Result.failure(DataResponseError.custom("Missing service")))
            return
        }
        
        self.service?.fetchNews(fromDate: fromDate, toDate: toDate, completion: { [weak self] result in
            
            switch result {
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(Result.failure(error))
                }
            case .success(let response):
                
              //  self?.dataList = response.articles
              self?.dataList  = response.articles.sorted {$0.publishedAt > $1.publishedAt}
                DispatchQueue.main.async {
                    completion(Result.success(response.articles))
                }
            }
        })
    }
    
}
