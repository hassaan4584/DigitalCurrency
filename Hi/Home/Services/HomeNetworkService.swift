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

    func fetchCurrencyData(function: AppConstants.FunctionType, currencyCode: AppConstants.DigitalCurrencyCode, marketCode: AppConstants.MarketCode, onSuccess: @escaping ((DigitalCurrencyDTO) -> Void), onFailure: @escaping ((NetworkError) -> Void) ) {
        let queryParams: QueryParams = ["function": function.rawValue, "symbol": currencyCode.rawValue, "market": marketCode.rawValue, "apikey": AppConstants.ApiConstants.apiKey.rawValue]
        let currencyEndpoint = HiEndpoint.query(queryParams: queryParams)
        self.networkManager.makeCall(withEndPoint: currencyEndpoint)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let err):
                    onFailure(err)
                case .finished:
                    break
                }
            }, receiveValue: { (currencyDTO: DigitalCurrencyDTO) in
                onSuccess(currencyDTO)
            })
            .store(in: &cancellables)
    }
}
