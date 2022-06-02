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
    
}

protocol CryptoDetailViewModelProtocol: CryptoDetailViewModelOutputProtocol { }

final class CryptoDetailViewModel: CryptoDetailViewModelProtocol {
    let cryptoItem: CryptoDetails
    
    init( cryptoItemDetails: CryptoDetails) {
        self.cryptoItem = cryptoItemDetails
    }
    
    
    
    // MARK: CryptoDetailViewModelOutputProtocol
    var screenTitle: String { "\(self.cryptoItem.metadata.the3DigitalCurrencyName) Details" }
    //
}
