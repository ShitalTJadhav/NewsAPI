//
//  ParseHelper.swift
//
//  Created by Tushar  Jadhav on 2019-03-04.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import Foundation

class ParseHelper {
    
   static func parseData<T: Decodable>(data : Data?, completion: @escaping (Result<T, DataResponseError>) -> Void) {
        
        guard let data = data else {
            completion(Result.failure(DataResponseError.custom("Failed to fetch data")))
            return
        }
        
        guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
            completion(Result.failure(DataResponseError.decoding))
            return
        }
        
        completion(Result.success(decodedResponse))
    }
}
