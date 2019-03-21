//
//  NewsViewModelTest.swift
//  NewsAPITests
//
//  Created by Tushar  Jadhav on 2019-03-04.
//  Copyright © 2019 Shital  Jadhav. All rights reserved.
//

import XCTest
@testable import NewsAPI

class NewsViewModelTest: XCTestCase {

    var viewModel : NewsListViewModel!
    var mockNetworkService: MockNetworkService!
    var newsService: NewsService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockNetworkService = MockNetworkService()
        newsService = NewsService(networking: self.mockNetworkService)
        viewModel = NewsListViewModel(service: newsService)
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockNetworkService = nil
        newsService = nil
    }

    func testFetchActivityFeeds() {
        
        let expectation = self.expectation(description: #function)
        self.mockNetworkService.fileName = "Article"
        
        self.viewModel.loadNewsData{ result in
            switch result {
            case .failure(let error):
                XCTAssert(false, "Service not be able to fetch news articles - \(error.reason)")
            case .success(let newsModel):
                XCTAssertEqual(newsModel.count, 20)
                expectation.fulfill()
            }
        }
    
        wait(for: [expectation], timeout: 1)
    }


    
}
