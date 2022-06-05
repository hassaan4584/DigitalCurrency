//
//  NetworkManagerProtocol.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import Foundation
import Combine

protocol NetworkManagerProtocol: AnyObject {

    var session: URLSession { get }
    var logger: NetworkLoggerProtocol { get }
    var cancellables: Set<AnyCancellable> { get set }

    /// This function makes the network call using Comnine for the passed `Endpoint`
    @discardableResult
    func makeCall<T: Codable> (withEndPoint endpoint: Endpoint) -> Future<T, NetworkError>

}

extension NetworkManagerProtocol {

    func makeCall<T: Codable> (withEndPoint endpoint: Endpoint) -> Future<T, NetworkError> {

        return Future<T, NetworkError> { promise in
            let urlRequest = endpoint.createRequest()
            self.logger.log(request: urlRequest)
            self.session.dataTaskPublisher(for: urlRequest)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.emptyData
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(NetworkError.generic(decodingError)))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.generic(error)))
                        }
                    }
                } receiveValue: { decodedObject in
                    promise(.success(decodedObject))
                }
                .store(in: &self.cancellables)
        }
    }
}
