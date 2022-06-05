//
//  HomeViewModel.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    /// Network service to fetch History data
    private let homeNetworkService: HomeNetworkService
    /// object contain all the information from server
    private var digitalCurrencyData: DigitalCurrencyDTO?
    /// Sorted items list as per the selected sorting technique
    private var sortedItems: [TimeSeriesDigitalCurrencyDaily]
    /// Page Size used for pagination
    private let pageSize: Int
    /// Total items currently shown
    private var currentlyShownItems: Int

    init(homeNetworkService: HomeNetworkService, pageSize: Int=10, sortingMethod: CurrencyHistorySorting = .dateDescending) {
        self.homeNetworkService = homeNetworkService
        self.pageSize = pageSize
        self.currentlyShownItems = 0
        self.digitalCurrencyData = nil
        self.errorMessage = Observable("")
        self.displayItems = Observable([])
        self.cryptoDetails = Observable(nil)
        self.currentSorting = sortingMethod
        self.sortedItems = self.digitalCurrencyData?.timeSeriesDigitalCurrencyDaily.array ?? []
        self.sortingTextFieldPlaceholder = Observable("")
    }

    private func resetPagination() {
        self.currentlyShownItems = 0
        self.displayItems.value.removeAll()
    }

    /// Returns the data in the respective sorted order
    private func getData(with sortingMethod: CurrencyHistorySorting) -> [TimeSeriesDigitalCurrencyDaily] {
        guard let arr = self.digitalCurrencyData?.timeSeriesDigitalCurrencyDaily.array else { return [] }

        switch sortingMethod {
        case .dateAscending:
            return (arr.sorted { $0.dateStr < $1.dateStr })
        case .dateDescending:
            return (arr.sorted { $0.dateStr > $1.dateStr })
        case .marketCapAscending:
            return (arr.sorted { $0.marketCapValue < $1.marketCapValue})
        case .marketCapDescending:
            return (arr.sorted { $0.marketCapValue > $1.marketCapValue})
        }
    }

    // MARK: HomeViewModelInputProtocol

    /// Setup data for the next page and update`displayItems` property
    func showNextPage() {
        guard (self.sortedItems.count) > currentlyShownItems+pageSize-1 else { return }
        let newItems = self.sortedItems[currentlyShownItems...currentlyShownItems+pageSize-1]
        displayItems.value.append(contentsOf: newItems)
        currentlyShownItems += pageSize
    }

    /// Fetch data from server
    func fetchCurrencyInformation() {
        self.isLoading.value = true
        self.homeNetworkService.fetchCurrencyData(function: "DIGITAL_CURRENCY_DAILY", currencyCode: "BTC", marketCode: "USD") { [weak self] digitalCurrencyDto in
            guard let self = self else { return }
            self.isLoading.value = false
            self.digitalCurrencyData = digitalCurrencyDto
            self.sortedItems = self.getData(with: self.currentSorting)
            self.showNextPage()
        } onFailure: { [weak self] err in
            guard let self = self else { return }
            self.isLoading.value = false
            self.errorMessage.value = err.errorMessageStr
        }
    }

    func didSelectDisplayitem(index: Int) {
        guard index < self.displayItems.value.count else { return }
        guard let currencyDetailInfo = self[index] else { return }
        guard let metadata = self.digitalCurrencyData?.metadata else { return }
        let selectedCryptoDetails = CryptoDetails(metadata: metadata, currencyDetails: currencyDetailInfo)
        self.cryptoDetails.value = selectedCryptoDetails
    }

    func updateSorting(with newValue: CurrencyHistorySorting) {
        guard newValue != self.currentSorting else { return }
        self.resetPagination()
        self.sortedItems = self.getData(with: newValue)
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
    /// Title of the History List Screen
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
