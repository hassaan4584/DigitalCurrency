//
//  CryptoDetailViewModel.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import Foundation

struct CryptoDetails {
    let metadata: DigitalCurrencyMetadata
    let currencyDetails: TimeSeriesDigitalCurrencyDaily
}

protocol CryptoDetailViewModelOutputProtocol {
    var cryptoItem: CryptoDetails { get }
    var screenTitle: String { get }
    var detailItemsList: [CurrencyDetailsItem] { get }
}
protocol CryptoDetailViewModelProtocol: CryptoDetailViewModelOutputProtocol { }

final class CryptoDetailViewModel: CryptoDetailViewModelProtocol {
    let cryptoItem: CryptoDetails
    var detailItemsList: [CurrencyDetailsItem]
    init( cryptoItemDetails: CryptoDetails) {
        self.cryptoItem = cryptoItemDetails

        self.detailItemsList = []
        let sortedKeys =  Array(cryptoItem.currencyDetails.dictionary.keys).sorted(by: <)
        for key in sortedKeys {
            guard let value = cryptoItem.currencyDetails.dictionary[key] else { continue }
            self.detailItemsList.append(CurrencyDetailsItem(key: key, value: value))
        }

    }

    // MARK: CryptoDetailViewModelOutputProtocol
    var screenTitle: String { "\(self.cryptoItem.metadata.the3DigitalCurrencyName) Details" }
    //
}
