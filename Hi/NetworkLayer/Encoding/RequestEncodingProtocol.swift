//
//  RequestEncodingProtocol.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/1/22.
//

import Foundation

protocol RequestEncodingProtocol {

    func encodeRequest(urlRequest: inout URLRequest, _ queryParams: QueryParams)
}
