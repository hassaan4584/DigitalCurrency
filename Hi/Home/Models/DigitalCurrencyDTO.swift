//
//  DigitalCurrencyDTO.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/6/22.
//

import Foundation

struct DigitalCurrencyDTO: Codable {
    let metadata: DigitalCurrencyMetadata
    let timeSeriesDigitalCurrencyDaily: TimeSeriesDigitalCurrencyDailyDTO

    enum CodingKeys: String, CodingKey {
        case metadata = "Meta Data"
        case timeSeriesDigitalCurrencyDaily = "Time Series (Digital Currency Daily)"
    }

}
