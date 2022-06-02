//
//  CryptoDetailsVCTests.swift
//  HiTests
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import XCTest
@testable import Hi

class CryptoDetailsVCTests: XCTestCase {

    var sut: CryptoDetailVC!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Testing Details VC if it correctly instantiated
    func testStoryboardIdentifier_whenCorrectStoryboardIdGive_shouldInstantiateDetailsVC() throws {
        guard let currencyData = UnitTestUtils.getCurrencyData(from: "digitalCurrency_eth_usd") else { return }
        guard let digitalCurrencyInfo = try? JSONDecoder().decode(DigitalCurrencyDTO.self, from: currencyData) else {
            return
        }

        sut = CryptoDetailVC.createCryptoDetailsScreen(viewModel: CryptoDetailViewModel(cryptoItemDetails: CryptoDetails(metadata: digitalCurrencyInfo.metadata, currencyDetails: digitalCurrencyInfo.timeSeriesDigitalCurrencyDaily.array[0])))
        
        // Assert
        XCTAssertNotNil(sut)
        
    }


}
