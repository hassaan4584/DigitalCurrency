//
//  HomeViewModelTests.swift
//  HiTests
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import XCTest
@testable import Hi

class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    private let digitalCurrency_eth_usd: String = "digitalCurrency_eth_usd"

    override func setUpWithError() throws {
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()))
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testExample() throws {
        let expectation = self.expectation(description: "Currency Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrency_eth_usd)
        MockURLProtocol.stubResponseData = currencyData
        
        sut.displayItems.observe(on: self) { currecyList in
            expectation.fulfill()
        }
        
        sut.errorMessage.observe(on: self) { err in
            print(err)
            XCTFail()
        }
        sut.fetchCurrencyInformation()
        
        self.waitForExpectations(timeout: 1.0, handler: nil)
    
    }


}
