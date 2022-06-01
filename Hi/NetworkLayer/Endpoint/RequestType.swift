//
//  RequestType.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/1/22.
//

import Foundation

enum RequestType {
    /// Request with no query params and no body params
    case simple
    /// Request with only query params
    case query(_ queryParams: QueryParams)
}
