//
//  NetworkService.swift
//
//  Created by Tushar  Jadhav on 2019-03-03.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import Foundation

protocol NetworkingProtocol {
    
    /// Fetch data from url and parameters query
    /// - Parameters:
    ///   - url: The url
    ///   - parameters: Parameters as query items
    ///   - completion: Called when operation finishes
    /// - Returns: The data task
    @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask?
}

/// Used to fetch data from network
class NetworkService : NetworkingProtocol {
    
    private let session: URLSession!
    
    lazy var baseURL: URL = {
        return URL(string: "https://newsapi.org/v2/everything")!
    }()
    
    lazy var apiKey: String = {
        return "c6aaf288a51440f2b58832506650e18d"
    }()

    
    public static let shared = NetworkService()
    
    private init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }
    
    @discardableResult func fetch(resource: Resource, completion: @escaping (Data?) -> Void) -> URLSessionTask? {
        guard let request = makeRequest(resource: resource) else {
            completion(nil)
            return nil
        }
        
        let task = session.dataTask(with: request, completionHandler: { data, _, error in
        
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            completion(data)
        })
        
        task.resume()
        return task
    }
    

    /// - Returns: Constructed URL request
    private func makeRequest( resource: Resource) -> URLRequest? {
        
        //let escapedPath = resource.path?.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlHostAllowed)
        let url = resource.path.map({ resource.url.appendingPathComponent($0) }) ?? resource.url
        
        guard var component = URLComponents(url: url , resolvingAgainstBaseURL: true) else {
            assertionFailure()
            return nil
        }
        
        component.queryItems = resource.parameters.map({
            return URLQueryItem(name: $0, value: $1)
        })
        
        guard let resolvedUrl = component.url else {
            assertionFailure()
            return nil
        }
        
        var request = URLRequest(url: resolvedUrl)
        request.httpMethod = resource.httpMethod
        
        // Check internet connection
        if let reachability = Reachability(), !reachability.isReachable {
            request.cachePolicy = .returnCacheDataDontLoad
        }
        
        return request
    }
}
