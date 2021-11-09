//
//  CocktailTests.swift
//  CocktailTests
//
//  Created by Abdul Rahim on 08/11/21.
//

import XCTest
import Combine
@testable import Cocktail

class CocktailTests: XCTestCase {

    var subscriptions = Set<AnyCancellable>()
    
    override func tearDown() {
        subscriptions = []
    }
    
    /// test for news fetcher api
    func test_fetching_api_data() {
        let mock = ApiMockResources()
        let fetcher = CocktailViewModel(apiResource: mock)
        
        XCTAssertEqual(fetcher.drinks?.drinks, nil, "starting with no data...")
        
        let promise = expectation(description: "loading 3 news data count...")
        fetcher.$drinks.sink{ (completion) in
            XCTFail()
        } receiveValue: { (drink) in
            if drink?.drinks.count == 3 {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [promise], timeout: 1)
        
    }

}
