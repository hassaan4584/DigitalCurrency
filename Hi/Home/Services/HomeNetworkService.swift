//
//  HomeNetworkService.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation

protocol NetowkService {
    var networkManager: NetworkManagerProtocol { get }
}
final class HomeNetworkService: NetowkService {
    let networkManager: NetworkManagerProtocol
    
    init( networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func fetchCurrencyData(function: String, currencyCode: String, marketCode: String, onSuccess: @escaping ((DigitalCurrencyDTO) -> Void), onFailure: @escaping ((NetworkError) -> Void) ) {
        let queryParams: QueryParams = ["function": function, "symbol" : currencyCode, "market": marketCode, "apikey": "5WDAFC09SA7SXNBI"]
        let currencyEndpoint = HiEndpoint.query(queryParams: queryParams)
        self.networkManager.makeCall(withEndPoint: currencyEndpoint) { (result: Result<DigitalCurrencyDTO, NetworkError>) in
            switch result {
            case .success(let success):
                onSuccess(success)
            case .failure(let failure):
                onFailure(failure)
            }
        }
    }
}
