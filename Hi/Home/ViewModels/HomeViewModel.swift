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
    func updateSorting(with newValue: CurrencyHistorySorting)
}

protocol HomeViewModelOutputProtocol {
    /// Handles the loading indicator based on its state
    var isLoading: Observable<Bool> { get }
    /// Observable error message that is to be shown to user
    var errorMessage: Observable<String> { get }
    /// Title of the Crypto List Screen
    var screenTitle: String { get }
    var displayItems: Observable<[TimeSeriesDigitalCurrencyDaily]> { get }

    var currentSorting: CurrencyHistorySorting { get }

    var cryptoDetails: Observable<CryptoDetails?> { get }

    var sortingTextFieldPlaceholder: Observable<String> { get }
    var availableSortingOptions: [CurrencyHistorySorting] { get }
    subscript( index: Int) -> TimeSeriesDigitalCurrencyDaily? { get }
}

protocol HomeViewModelProtocol: HomeViewModelInputProtocol, HomeViewModelOutputProtocol { }

enum CurrencyHistorySorting: String {
    case dateAscending
    case dateDescending
    case marketCapAscending
    case marketCapDescending

    /// Name to be shown in the text field
    var sortingName: String {
        switch self {
        case .dateAscending:
            return "Sort by Date - Ascending"
        case .dateDescending:
            return "Sort by Date - Descending"
        case .marketCapAscending:
            return "Sort by Market Cap - Ascending"
        case .marketCapDescending:
            return "Sort by Market Cap - Descending"
        }
    }
}

final class HomeViewModel: HomeViewModelProtocol {
    private let homeNetworkService: HomeNetworkService

    private let items: Observable<DigitalCurrencyDTO?>
    private var sortedItems: [TimeSeriesDigitalCurrencyDaily]
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
        self.currentSorting = CurrencyHistorySorting.dateDescending
        self.sortedItems = (self.items.value?.timeSeriesDigitalCurrencyDaily.array.sorted { $0.dateStr > $1.dateStr }) ?? []
        self.sortingTextFieldPlaceholder = Observable("")
    }

    private func resetPagination() {
        self.currentlyShownItems = 0
        self.displayItems.value.removeAll()
    }
    /// Setup data for the next page and update`displayItems` property
    func showNextPage() {
        guard (self.sortedItems.count) > currentlyShownItems+pageSize-1 else { return }
        let newItems = self.sortedItems[currentlyShownItems...currentlyShownItems+pageSize-1]
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
            self.items.value = digitalCurrencyDto
            self.sortedItems = (self.items.value?.timeSeriesDigitalCurrencyDaily.array.sorted { $0.dateStr > $1.dateStr }) ?? []
            self.showNextPage()
        } onFailure: { [weak self] err in
            guard let self = self else { return }
            self.isLoading.value = false
            print(err.errorMessageStr)
            self.errorMessage.value = err.errorMessageStr
        }
    }

    // MARK: HomeViewModelInputProtocol
    func didSelectDisplayitem(index: Int) {
        guard let metadata = self.items.value?.metadata else { return }
        guard index < self.displayItems.value.count else { return }
        guard let currencyDetailInfo = self[index] else { return }
        let selectedCryptoDetails = CryptoDetails(metadata: metadata, currencyDetails: currencyDetailInfo)
        self.cryptoDetails.value = selectedCryptoDetails
    }

    func updateSorting(with newValue: CurrencyHistorySorting) {
        guard newValue != self.currentSorting else { return }
        switch newValue {
        case .dateAscending:
            self.sortedItems = (self.items.value?.timeSeriesDigitalCurrencyDaily.array.sorted { $0.dateStr < $1.dateStr }) ?? []
        case .dateDescending:
            self.sortedItems = (self.items.value?.timeSeriesDigitalCurrencyDaily.array.sorted { $0.dateStr > $1.dateStr }) ?? []
        case .marketCapAscending:
            self.sortedItems = (self.items.value?.timeSeriesDigitalCurrencyDaily.array.sorted { $0.marketCapValue < $1.marketCapValue}) ?? []
        case .marketCapDescending:
            self.sortedItems = (self.items.value?.timeSeriesDigitalCurrencyDaily.array.sorted { $0.marketCapValue > $1.marketCapValue}) ?? []
        }
        self.resetPagination()
        self.showNextPage()
        self.currentSorting = newValue
        self.sortingTextFieldPlaceholder.value = newValue.sortingName
    }

    subscript( index: Int) -> TimeSeriesDigitalCurrencyDaily? {
        guard index >= 0, index < self.displayItems.value.count else { return nil }
        return self.displayItems.value[index]
    }

    // MARK: HomeViewModelOutputProtocol
    /// Handles the loading indicator based on its state
    let isLoading: Observable<Bool> = Observable(false)
    /// Observable error message that is to be shown to user
    let errorMessage: Observable<String>
    /// Title of the Crypto Details Screen
    var screenTitle: String { "Bitcoin History" }
    /// Datasource for the elements to display data from
    var displayItems: Observable<[TimeSeriesDigitalCurrencyDaily]>
    var cryptoDetails: Observable<CryptoDetails?>
    var currentSorting: CurrencyHistorySorting
    var availableSortingOptions: [CurrencyHistorySorting] {
        return [.dateDescending, .dateAscending, .marketCapDescending, .marketCapAscending]
    }
    var sortingTextFieldPlaceholder: Observable<String>

}
