//
//  HomeNetworkService.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation
import Combine

protocol NetowkService {
    var networkManager: NetworkManagerProtocol { get }
}

final class HomeNetworkService: NetowkService {
    let networkManager: NetworkManagerProtocol
    private var cancellables: Set<AnyCancellable>
    
    init( networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        self.cancellables = Set<AnyCancellable>()
    }
    
    func fetchCurrencyData(function: String, currencyCode: String, marketCode: String, onSuccess: @escaping ((DigitalCurrencyDTO) -> Void), onFailure: @escaping ((NetworkError) -> Void) ) {
        let queryParams: QueryParams = ["function": function, "symbol" : currencyCode, "market": marketCode, "apikey": "5WDAFC09SA7SXNBI"]
        let currencyEndpoint = HiEndpoint.query(queryParams: queryParams)
        self.networkManager.makeCall(withEndPoint: currencyEndpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let err):
                    onFailure(err)
                case .finished:
                    break;
                }
            }) { (currencyDTO: DigitalCurrencyDTO) in
                onSuccess(currencyDTO)
            }
            .store(in: &cancellables)
    }
}
