//
//  AppConstants.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import Foundation

struct AppConstants {

    enum ApiConstants: String {
        case apiKey = "5WDAFC09SA7SXNBI"
    }

    enum StoryboardName: String {
        case home = "Home"
        case cryptoDetails = "CryptoDetails"
    }

    enum FunctionType: String {
        case digitalCurrencyDaily = "DIGITAL_CURRENCY_DAILY"
    }

    enum DigitalCurrencyCode: String {
        case bitcoin = "BTC"
    }

    enum MarketCode: String {
        case usd = "USD"
    }
}
