//
//  HomeViewModel.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation

final class HomeViewModel {
    private let homeNetworkService: HomeNetworkService
    
    private let items: Observable<DigitalCurrencyDTO?>
    let errorMessage: Observable<String>
    
    private var totalItems: Int
    private let pageSize: Int
    private var currentlyShownItems: Int
    
    init(homeNetworkService: HomeNetworkService, pageSize: Int=10) {
        self.homeNetworkService = homeNetworkService
        self.pageSize = pageSize
        self.totalItems = 0
        self.currentlyShownItems = 0
        self.items = Observable(nil)
        self.errorMessage = Observable("")
        self.displayItems = Observable([])
    }
    
    func showNextPage() {
        guard (self.items.value?.timeSeriesDigitalCurrencyDaily.array.count ?? 0) > currentlyShownItems+pageSize-1 else { return }
        let newItems = self.items.value!.timeSeriesDigitalCurrencyDaily.array[currentlyShownItems...currentlyShownItems+pageSize-1]
        displayItems.value.append(contentsOf: newItems)
        currentlyShownItems += pageSize
    }
    
    func fetchCurrencyInformation() {
        let currencyData = UnitTestUtils.getCurrencyData(from: "digitalCurrency_eth_usd")
        MockURLProtocol.stubResponseData = currencyData

        self.isLoading.value = true
        self.homeNetworkService.fetchCurrencyData(function: "DIGITAL_CURRENCY_DAILY", currencyCode: "BTC", marketCode: "USD") { [weak self] digitalCurrencyDto in
            guard let self = self else { return }
            self.isLoading.value = false
            print(digitalCurrencyDto)
            self.items.value = digitalCurrencyDto
            self.showNextPage()
        } onFailure: { [weak self] err in
            guard let self = self else { return }
            self.isLoading.value = false
            print(err.errorMessageStr)
            self.errorMessage.value = err.errorMessageStr
        }

    }
    
    /// Handles the loading indicator based on its state
    let isLoading: Observable<Bool> = Observable(false)
    /// Observable error message that is to be shown to user
    let error: Observable<String> = Observable("")
    /// Title of the Restaurants List Screen
    var screenTitle: String { "CurrencyList" }
    var displayItems: Observable<[TimeSeriesDigitalCurrencyDaily]>

}
