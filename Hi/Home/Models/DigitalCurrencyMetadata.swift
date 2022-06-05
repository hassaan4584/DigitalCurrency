//
//  DigitalCurrencyMetadata.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation

struct DigitalCurrencyMetadata: Codable {
    let information, digitalCurrencyCode, digitalCurrencyName, marketCode: String
    let marketName, lastRefreshed, timeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case digitalCurrencyCode = "2. Digital Currency Code"
        case digitalCurrencyName = "3. Digital Currency Name"
        case marketCode = "4. Market Code"
        case marketName = "5. Market Name"
        case lastRefreshed = "6. Last Refreshed"
        case timeZone = "7. Time Zone"
    }
}
