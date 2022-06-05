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
    /// Helper function to create a URLRequest object using EndPoint
    func createRequest() -> URLRequest
}
