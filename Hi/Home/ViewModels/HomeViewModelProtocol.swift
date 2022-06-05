//
//  HomeViewModelProtocol.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import Foundation

protocol HomeViewModelInputProtocol {
    /// Perform action when an item is selected
    func didSelectDisplayitem(index: Int)
    /// update paginated data to show next page
    func showNextPage()
    /// fetch currency information from server
    func fetchCurrencyInformation()
    /// apply new sorted method on the displayed list of items
    func updateSorting(with newValue: CurrencyHistorySorting)
}

protocol HomeViewModelOutputProtocol {
    /// Handles the loading indicator based on its state
    var isLoading: Observable<Bool> { get }
    /// Observable error message that is to be shown to user
    var errorMessage: Observable<String> { get }
    /// Title of the History List Screen
    var screenTitle: String { get }
    /// Paginated items that are actually shown to the user
    var displayItems: Observable<[TimeSeriesDigitalCurrencyDaily]> { get }
    /// currently applied sorting technique
    var currentSorting: CurrencyHistorySorting { get }
    /// Crypto Details items that will be used to show on next details screen
    var cryptoDetails: Observable<CryptoDetails?> { get }
    /// Placeholder text for the Sorting option input
    var sortingTextFieldPlaceholder: Observable<String> { get }
    /// The list of sorting options available
    var availableSortingOptions: [CurrencyHistorySorting] { get }
    /// subscript notation to get `TimeSeriesDigitalCurrencyDaily` data for the given list item
    subscript( index: Int) -> TimeSeriesDigitalCurrencyDaily? { get }
}

protocol HomeViewModelProtocol: HomeViewModelInputProtocol, HomeViewModelOutputProtocol { }
