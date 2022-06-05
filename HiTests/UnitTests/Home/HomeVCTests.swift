//
//  HomeVCTests.swift
//  HiTests
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import XCTest
@testable import Hi

class HomeVCTests: XCTestCase {

    var sut: HomeViewController!

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testSearchFieldPlaceholder_whenSortedByDateAsc_shouldShowCorrectPlaceholder() throws {
        // Arrange + Act
        let sortingMethod = CurrencyHistorySorting.dateAscending
        let homeViewModel = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: 10, sortingMethod: sortingMethod)
        sut = HomeViewController.createListViewController(homeViewModel: homeViewModel)
        sut.loadViewIfNeeded()

        // Assert
        XCTAssertEqual(self.sut.sortTextField.placeholder, sortingMethod.sortingName)
    }

    func testMessageInfoLabel_whenErrorIsSet_shouldUpdateErrorMessaga() throws {
        // Arrange
        let currencyData = UnitTestUtils.getCurrencyData(from: "digitalCurrency_btc_usd")
        MockURLProtocol.stubResponseData = currencyData
        let homeViewModel = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: 10, sortingMethod: .dateAscending)
        sut = HomeViewController.createListViewController(homeViewModel: homeViewModel)
        sut.loadViewIfNeeded()
        let messageExpectation = expectation(description: "Message Update Expectation")

        // Act
        let message = "Some Test Error"
        homeViewModel.errorMessage.value = message

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            XCTAssertEqual(self.sut.infoLabel.text, message)
            messageExpectation.fulfill()
        }
        self.wait(for: [messageExpectation], timeout: 2.0)

    }

}
