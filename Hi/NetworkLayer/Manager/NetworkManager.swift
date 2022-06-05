//
//  NetworkManager.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation
import Combine

typealias ResultClosure = (Result<(URLResponse, Data), Error>) -> Void

final class NetworkManager: NetworkManagerProtocol {

    let session: URLSession
    let logger: NetworkLoggerProtocol
    var cancellables = Set<AnyCancellable>()

    init() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.session = URLSession(configuration: config)
        self.logger = NetworkLogger()
    }

    /// Custom init function for initializer based dependecy injection
    init(session: URLSession, logger: NetworkLogger) {
        self.session = session
        self.logger = logger
    }

}
