//
//  HiUITests.swift
//  HiUITests
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import XCTest

class HiUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app.terminate()
    }
    
    func testNormalLaunch_whenTheAppIsLaunched_HomeScreenHasNavigationController() throws {
        app = XCUIApplication()
        app.launchArguments = [UITestingConstants.LaunchArguments.mockHomeNetworkService.rawValue]
        app.launch()

        let title = app.staticTexts["Currency List"].waitForExistence(timeout: 1.0)
        XCTAssertTrue(title)
    }

}
