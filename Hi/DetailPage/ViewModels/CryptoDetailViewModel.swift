//
//  CryptoDetailViewModel.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/2/22.
//

import Foundation

final class CryptoDetailViewModel: CryptoDetailViewModelProtocol {
    init( cryptoItemDetails: CryptoDetails) {
        self.cryptoItem = cryptoItemDetails

        var detailItemsList = [CurrencyDetailsItem]()
        let sortedKeys =  Array(cryptoItem.currencyDetails.dictionary.keys).sorted(by: <)
        for key in sortedKeys {
            guard let value = cryptoItem.currencyDetails.dictionary[key] else { continue }
            detailItemsList.append(CurrencyDetailsItem(key: key, value: value))
        }
        self.detailItemsList = detailItemsList
    }

    // MARK: CryptoDetailViewModelOutputProtocol
    var screenTitle: String { "\(self.cryptoItem.metadata.the3DigitalCurrencyName) Details" }
    let cryptoItem: CryptoDetails
    let detailItemsList: [CurrencyDetailsItem]
}
