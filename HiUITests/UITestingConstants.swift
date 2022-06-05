//
//  UITestingConstants.swift
//  HiUITests
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import Foundation

struct UITestingConstants {

    enum LaunchArguments: String {
        /// Indicates that the app is run for UI Testing
        case enableUITesting
        /// Indicates that network service for HomeScreen should be mock
        case mockHomeNetworkService

    }
}
