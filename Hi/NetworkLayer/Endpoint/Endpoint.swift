//
//  Endpoint.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation

protocol Endpoint {

    /// The host. for example www.google.com
    var baseURL: URL { get }
    /// `path` of the request
    var path: String { get }
    /// The headers accompnying http request
    var headers: [String: String]? { get }
    /// The `http` method of request
    var httpMethod: String { get }

    var requestType: RequestType { get }

    /// Helper function to create a URLRequest object using Endpoint. If someone doesnt override this, default implementation will be used
    func createRequest() -> URLRequest
}

extension Endpoint {

    /// Helper function to create a URLRequest object using EndPoint
    func createRequest() -> URLRequest {
        let url = self.baseURL.appendingPathComponent(self.path)
        var urlRequest = URLRequest.init(url: url)
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.httpMethod = self.httpMethod

        switch self.requestType {
        case .simple:
            break
        case .query(let queryParams):
            RequestEncoder().encodeRequest(urlRequest: &urlRequest, queryParams)
        }

        return urlRequest
    }
}
