//
//  HomeViewModel.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation

protocol HomeViewModelInputProtocol {
    /// Perform action when an item is selected
    func didSelectDisplayitem(index: Int)
    func showNextPage()
    func fetchCurrencyInformation()
}

protocol HomeViewModelOutputProtocol {
    /// Handles the loading indicator based on its state
    var isLoading: Observable<Bool> { get }
    /// Observable error message that is to be shown to user
    var errorMessage: Observable<String> { get }
    /// Title of the Crypto List Screen
    var screenTitle: String { get }
    var displayItems: Observable<[TimeSeriesDigitalCurrencyDaily]> { get }
    
    var cryptoDetails: Observable<CryptoDetails?> { get }
    subscript( index: Int) -> TimeSeriesDigitalCurrencyDaily? { get }
}


protocol HomeVieWModelProtocol: HomeViewModelInputProtocol, HomeViewModelOutputProtocol { }

final class HomeViewModel: HomeVieWModelProtocol {
    private let homeNetworkService: HomeNetworkService
    
    private let items: Observable<DigitalCurrencyDTO?>
    
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
        self.cryptoDetails = Observable(nil)
    }
    
    /// Setup data for the next page and update`displayItems` property
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
    
    func didSelectDisplayitem(index: Int) {
        guard let metadata = self.items.value?.metadata else { return }
        guard index < self.displayItems.value.count else { return }
        guard let currencyDetailInfo = self[index] else { return }
        let selectedCryptoDetails = CryptoDetails(metadata: metadata, currencyDetails: currencyDetailInfo)
        self.cryptoDetails.value = selectedCryptoDetails
    }
    
    subscript( index: Int) -> TimeSeriesDigitalCurrencyDaily? {
        guard index >= 0, index < self.displayItems.value.count else { return nil }
        return self.displayItems.value[index]
    }
    
    /// Handles the loading indicator based on its state
    let isLoading: Observable<Bool> = Observable(false)
    /// Observable error message that is to be shown to user
    let errorMessage: Observable<String>
    /// Title of the Crypto Details Screen
    var screenTitle: String { "Currency List" }
    var displayItems: Observable<[TimeSeriesDigitalCurrencyDaily]>
    var cryptoDetails: Observable<CryptoDetails?>
    

}
