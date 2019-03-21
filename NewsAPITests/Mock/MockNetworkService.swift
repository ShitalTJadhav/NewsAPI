//
//  MockNetworkService.swift
//  NewsAPITests
//
//  Created by Tushar  Jadhav on 2019-03-03.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import Foundation
@testable import NewsAPI

final class MockNetworkService: NetworkingProtocol {
    
    var fileName: String?
    
    func fetch(resource: Resource, completion: @escaping (AnyObject?) -> Void) -> URLSessionTask? {
        
        let bundle = Bundle(for: MockNetworkService.self)

        guard let url = bundle.url(forResource: self.fileName, withExtension: "json") else {
            completion(nil)
            return nil
        }
        
        let data = try! Data(contentsOf: url)
        completion(data as AnyObject)
        
        return nil
    }
}
