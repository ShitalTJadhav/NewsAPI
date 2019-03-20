//
//  NewsService.swift
//
//  Created by Tushar  Jadhav on 2019-03-03.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import Foundation

final class NewsService {
    
    private let networking: NetworkingProtocol?
    
    init(networking: NetworkingProtocol?) {
        self.networking = networking
    }
    
    /// Fetch all activities that happened between from and to date
    ///
    /// - Parameter completion: Called when operation finishes
    func fetchNews(fromDate: String, toDate: String, completion: @escaping (Result<NewsResponceModel, DataResponseError>) -> Void) {
        
        let resource = Resource(url: NetworkService.shared.baseURL, path: "", parameters: [
            "q": "apple",
            "from": fromDate,
            "to": toDate,
            "sortBy":"popularity",
            "apiKey":NetworkService.shared.apiKey
            ])
        
        _ = networking?.fetch(resource: resource, completion: { data in
            
            if let error = data as? Error {
                completion(Result.failure(DataResponseError.custom(error.localizedDescription)))
                return
            }
            
    
            //Parse data and get result
            return ParseHelper.parseData(data: data as? Data, completion: completion)
        })
    }

}
