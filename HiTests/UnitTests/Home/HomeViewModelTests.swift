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
    private let digitalCurrencyBtcUsd: String = "digitalCurrency_btc_usd"

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

        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    /// When the first page is shown and next page data is requested, should correctly update data for next page
    func testPagination_whenInitialDataIsShown_nextPageIsRequested() throws {
        // Arrange
        let pageSize = 8
        var currentItems = pageSize * 1

        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: pageSize)
        let expectation = self.expectation(description: "Currency Expectation")
        expectation.expectedFulfillmentCount = 2
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyEthUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.displayItems.observe(on: self) { currencyList in
            XCTAssertEqual(currencyList.count, currentItems)
            expectation.fulfill()
        }

        sut.errorMessage.observe(on: self) { _ in
            XCTFail("Error Received")
        }

        sut.fetchCurrencyInformation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            currentItems = pageSize * 2
            self.sut.showNextPage()
        }

        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    /// When the second page  is shown and sorting is updated, 1st page with new sorting techniqe should be shown
    func testSorting_whenInitialDataIsShown_nextPageIsRequested() throws {
        // Arrange
        let pageSize = 10
        let sortingMethod = CurrencyHistorySorting.dateDescending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: pageSize, sortingMethod: sortingMethod)
        let sortingExpectation = self.expectation(description: "Sorting Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyEthUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.sortingTextFieldPlaceholder.observe(on: self) { _ in
            XCTAssertEqual(self.sut.displayItems.value.count, pageSize)
            sortingExpectation.fulfill()
        }

        sut.fetchCurrencyInformation()
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            self.sut.showNextPage()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.sut.updateSorting(with: .dateAscending)
        }
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    /// When default sorting is done by date in descending order, latest data shuld be shown at the top
    func testSorting_whenSortedByDateDesc_latestDataShouldBeFirst() throws {
        // Arrange
        let pageSize = 10
        let sortingMethod = CurrencyHistorySorting.dateDescending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: pageSize, sortingMethod: sortingMethod)
        let sortingExpectation = self.expectation(description: "Sorting Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyBtcUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.displayItems.observe(on: self) { currencyList in
            XCTAssertEqual(currencyList.first?.dateStr, "2022-06-05")
            sortingExpectation.fulfill()
        }
        sut.fetchCurrencyInformation()
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    /// When default sorting is done by date in ascending order, oldest data shuld be shown at the top
    func testSorting_whenSortedByDateAscending_OldestDataShouldBeFirst() throws {
        // Arrange
        let pageSize = 10
        let sortingMethod = CurrencyHistorySorting.dateAscending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: pageSize, sortingMethod: sortingMethod)
        let sortingExpectation = self.expectation(description: "Sorting Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyBtcUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.displayItems.observe(on: self) { currencyList in
            XCTAssertEqual(currencyList.first?.dateStr, "2019-09-10")
            sortingExpectation.fulfill()
        }
        sut.fetchCurrencyInformation()
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    /// When default sorting is done by date in ascending order, oldest data shuld be shown at the top
    func testSorting_whenSortedByMarketAscending_SmallestMarketValueShouldBeFirst() throws {
        // Arrange
        let pageSize = 10
        let sortingMethod = CurrencyHistorySorting.marketCapAscending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: pageSize, sortingMethod: sortingMethod)
        let sortingExpectation = self.expectation(description: "Sorting Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyBtcUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.displayItems.observe(on: self) { currencyList in
            XCTAssertEqual(currencyList.first?.dateStr, "2022-06-05")
            XCTAssertEqual(currencyList.first?.marketCapValue, 431.80768)
            sortingExpectation.fulfill()
        }
        sut.fetchCurrencyInformation()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    /// When default sorting is done by date in ascending order, oldest data shuld be shown at the top
    func testSorting_whenSortedByMarketDescending_LargestMarketValueShouldBeFirst() throws {
        // Arrange
        let pageSize = 10
        let sortingMethod = CurrencyHistorySorting.marketCapDescending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: pageSize, sortingMethod: sortingMethod)
        let sortingExpectation = self.expectation(description: "Sorting Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyBtcUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.displayItems.observe(on: self) { currencyList in
            XCTAssertEqual(currencyList.first?.dateStr, "2020-03-13")
            XCTAssertEqual(currencyList.first?.marketCapValue, 402201.673764)
            sortingExpectation.fulfill()
        }
        sut.fetchCurrencyInformation()
        self.waitForExpectations(timeout: 1.0, handler: nil)
    }

    /// Testing the subscript notation for accessing data for different cases
    func testSubscriptNotation_whenDataIsAccessedUsingSubscriptNotation_correctDataBeReturned() throws {
        let sortingMethod = CurrencyHistorySorting.dateAscending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: 10, sortingMethod: sortingMethod)
        let sortingExpectation = self.expectation(description: "Subscript Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyBtcUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        XCTAssertNil(self.sut[0]) // When data is not yet received
        sut.displayItems.observe(on: self) { _ in
            XCTAssertEqual(self.sut[0]?.dateStr, "2019-09-10")
            sortingExpectation.fulfill()
        }
        sut.fetchCurrencyInformation()
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testSelectedItem_whenFirstRowIsSelected_DetailsItemCorrectlyUpdates() throws {
        let sortingMethod = CurrencyHistorySorting.dateDescending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: 10, sortingMethod: sortingMethod)
        let sortingExpectation = self.expectation(description: "Selected Item Expectation")
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyBtcUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Assert + Act
        sut.displayItems.observe(on: self) { _ in
            self.sut.didSelectDisplayitem(index: 0)
        }

        sut.cryptoDetails.observe(on: self) { itemDetails in
            XCTAssertEqual(itemDetails?.currencyDetails.dateStr, "2022-06-05")
            sortingExpectation.fulfill()
        }
        sut.fetchCurrencyInformation()
        self.waitForExpectations(timeout: 2.0, handler: nil)
    }

    func testSelectedItem_WhenThereIsNoData_DetailsItemShouldBeNil() throws {
        let sortingMethod = CurrencyHistorySorting.dateDescending
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: 10, sortingMethod: sortingMethod)
        let currencyData = UnitTestUtils.getCurrencyData(from: digitalCurrencyBtcUsd)
        MockURLProtocol.stubResponseData = currencyData

        // Act
        self.sut.didSelectDisplayitem(index: 0)
        XCTAssertNil(self.sut.cryptoDetails.value)
    }

    func testApiError_WhenApiThrowsError_ErrorObserverIsCalled() throws {
        sut = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: MockNetworkManager()), pageSize: 10, sortingMethod: .dateDescending)
        let errorExpectation = self.expectation(description: "Error Message Expectation")
        MockURLProtocol.stubResponseData = nil

        // Act
        self.sut.errorMessage.observe(on: self) { message in
            XCTAssertEqual(message, "The data couldn’t be read because it isn’t in the correct format.")
            errorExpectation.fulfill()
        }

        sut.fetchCurrencyInformation()
        self.waitForExpectations(timeout: 1.0, handler: nil)

    }
}
