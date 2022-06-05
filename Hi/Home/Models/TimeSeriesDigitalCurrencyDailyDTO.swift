//
//  TimeSeriesDigitalCurrencyDailyDTO.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/6/22.
//

import Foundation

struct TimeSeriesDigitalCurrencyDailyDTO: Codable {
    var array: [TimeSeriesDigitalCurrencyDaily]

    private struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) { return nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var tempArray = [TimeSeriesDigitalCurrencyDaily]()
        for key in container.allKeys {
            let decodedObject = try container.decode(TimeSeriesDigitalCurrencyDaily.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            tempArray.append(decodedObject)
        }
        array = tempArray
    }
}
