//
//  NewsResponceModel.swift
//  NewsAPI
//
//  Created by Tushar  Jadhav on 2019-03-20.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import Foundation

struct NewsResponceModel: Decodable {
    
    let status: String
    let totalResults: Int
    let articles: [Article]
}
