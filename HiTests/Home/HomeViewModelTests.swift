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
    private let digitalCurrencyEthUsd: String = "digitalCurrency_eth_usd"

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    /// Testing initial api call such that page is correctly fetched
    func testApi_whenCorrectApiInfoIsGiven_page1IsCorrectlyReceived() throws {
        // Arrange

        let pageSize = 10
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()))
        let expectation = self.expectation(description: "Currency Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyEthUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.displayItems.observe(on: self) { currencyList in
            XCTAssertEqual(currencyList.count, pageSize)
            expectation.fulfill()
        }

        sut.errorMessage.observe(on: self) { _ in
            XCTFail("Error Received")
        }

        sut.fetchCurrencyInformation()

        self.waitForExpectations(timeout: 5.0, handler: nil)

    }

}
