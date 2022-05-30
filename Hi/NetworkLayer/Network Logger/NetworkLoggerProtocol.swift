//
//  NetworkLoggerProtocol.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation

public protocol NetworkLoggerProtocol {
   func log(request: URLRequest)
   func log(responseData data: Data?, response: URLResponse?)
   func log(error: Error)
}
