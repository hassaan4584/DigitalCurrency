//
//  HiEndpoint.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation

enum HiEndpoint: Endpoint {
    
case query(function: String, symbol: String, market: String, apikey: String)
    
    //query?function=DIGITAL_CURRENCY_DAILY&symbol=BTC&market=CNY&apikey=demo
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
    
    var queryParams: [String: String]? {
        switch self {
        case .query(let function, let symbol, let market, let apikey):
            return ["function": function, "symbol": symbol, "market": market, "apikey": apikey]
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var httpMethod: String {
        switch self {
        case .query:
            return HttpMethod.get.rawValue
        }
    }
    
    /// Helper function to create a URLRequest object using EndPoint
    func createRequest() -> URLRequest {
        let url = self.baseURL.appendingPathComponent(self.path)
        var urlRequest = URLRequest.init(url: url)
        urlRequest.allHTTPHeaderFields = self.headers
        urlRequest.httpMethod = self.httpMethod
        return urlRequest
    }

}
