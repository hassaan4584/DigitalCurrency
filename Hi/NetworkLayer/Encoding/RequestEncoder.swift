//
//  RequestEncoder.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/1/22.
//

import Foundation

class RequestEncoder: RequestEncodingProtocol {
    /**
     This function inserts the QueryParams into the URLRequest object
     
     - parameters:
         - urlRequest: The reference of the URLRequest object  that will be encoded with the QueryParams
        - queryParams: The QueryParams that are to be inserted into the request
     */
    func encodeRequest(urlRequest: inout URLRequest, _ queryParams: QueryParams) {
        guard let url = urlRequest.url else { return }
        guard var components: URLComponents = URLComponents.init(url: url, resolvingAgainstBaseURL: false) else { return }

        components.queryItems = [URLQueryItem].init()
        for (key) in queryParams.keys.sorted() {
            guard let value = queryParams[key] else { continue }
            let percentEncodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)?.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "&+").inverted)
            let queryItem = URLQueryItem.init(name: key, value: percentEncodedValue)
            components.percentEncodedQueryItems?.append(queryItem)
        }
        urlRequest.url = components.url
    }
}
