//
//  NetworkManagerProtocol.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation

// MARK: NetworkManagerProtocol
protocol NetworkManagerProtocol {

    /// This function makes the network call for the passed `Endpoint`
    /// - Returns: The network request of `URLSessionDataTask`
    @discardableResult
    func makeCall<T: Codable> (withEndPoint endpoint: Endpoint, _ completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask
}

extension NetworkManagerProtocol {
//    /// Helper function to create a URLRequest object using EndPoint
//    func createRequest(with endpoint: Endpoint) -> URLRequest {
//        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
//        var urlRequest = URLRequest.init(url: url)
//        urlRequest.allHTTPHeaderFields = endpoint.headers
//        urlRequest.httpMethod = endpoint.httpMethod
//        return urlRequest
//    }
}

