//
//  CryptoDetailViewModelProtocol.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import Foundation

protocol CryptoDetailViewModelOutputProtocol {
    /// Crypto Details Item that contains all inforrmation related to selected crypto history item
    var cryptoItem: CryptoDetails { get }
    /// Title to be displayed on the screen
    var screenTitle: String { get }
    /// List of items of crypto related information
    var detailItemsList: [CurrencyDetailsItem] { get }
}

protocol CryptoDetailViewModelProtocol: CryptoDetailViewModelOutputProtocol { }
