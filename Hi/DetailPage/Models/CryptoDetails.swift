//
//  CryptoDetails.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import Foundation

struct CryptoDetails {
    /// Metadata associated with each Crypto Item
    let metadata: DigitalCurrencyMetadata
    /// Daily currency item that contains information about each day
    let currencyDetails: TimeSeriesDigitalCurrencyDaily
}
