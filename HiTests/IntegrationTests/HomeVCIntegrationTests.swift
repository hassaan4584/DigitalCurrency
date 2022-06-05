//
//  HomeVCIntegrationTests.swift
//  HiTests
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import XCTest
@testable import Hi

class HomeVCIntegrationTests: XCTestCase {

    var sut: HomeViewController!
    var homeViewModel: HomeViewModel!

    override func setUpWithError() throws {
        homeViewModel = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: NetworkManager()), pageSize: 10, sortingMethod: .dateDescending)
        sut = HomeViewController.createListViewController(homeViewModel: homeViewModel)
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        homeViewModel = nil
        sut = nil
    }

    func testHomeVC_whenEverythingIsCorrect_dataOnHomeShouldCorrectlyPopulate() throws {
        // Arrange
        let expectation = expectation(description: "History Expectation")

        // Aseert + Act
        homeViewModel.displayItems.observe(on: self) { _ in
            XCTAssertEqual(self.homeViewModel.displayItems.value.count, 10)
            expectation.fulfill()
        }
        homeViewModel.errorMessage.observe(on: self) { _ in
            XCTFail("Should not have received any error")
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
