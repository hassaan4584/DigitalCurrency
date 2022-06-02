//
//  MockNetworkManager.swift
//  HiTests
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation
import Combine
@testable import Hi

class MockNetworkManager: NetworkManagerProtocol {

    let session: URLSession
    let logger: NetworkLoggerProtocol
    var cancellables = Set<AnyCancellable>()

    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        // setting custom protocol classes for mocking api data
        config.protocolClasses = [MockURLProtocol.self]
        self.session = URLSession(configuration: config)
        self.logger = NetworkLogger()

    }
    init(session: URLSession, logger: NetworkLogger) {
        self.session = session
        self.logger = logger
    }

}
