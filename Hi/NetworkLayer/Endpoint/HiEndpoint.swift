//
//  HiEndpoint.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation

typealias QueryParams = [String: String]

enum HiEndpoint: Endpoint {

case query(queryParams: QueryParams)

    var baseURL: URL {
        guard let url = URL(string: "https://www.alphavantage.co") else {
            fatalError("Invalid Base URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .query:
            return "query"
        }
    }

    var headers: [String: String]? {
        ["User-Agent": "Hi iOS App"]
    }

    var httpMethod: String {
        switch self {
        case .query:
            return HttpMethod.get.rawValue
        }
    }

    var requestType: RequestType {
        switch self {
        case .query(let queryParams):
            return RequestType.query(queryParams)
        }
    }
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
