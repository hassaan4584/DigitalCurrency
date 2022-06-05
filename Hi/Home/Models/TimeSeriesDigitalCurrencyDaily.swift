//
//  TimeSeriesDigitalCurrencyDaily.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/6/22.
//

import Foundation

struct TimeSeriesDigitalCurrencyDaily: Codable, Hashable {

    let dictionary: [String: String]
    let dateStr: String
    struct DynamicCodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        var intValue: Int?
        init?(intValue: Int) { return nil }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        var dit: [String: String] = [:]
        for key in container.allKeys {
            let str = try container.decode(String.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
            dit[key.stringValue] = str
        }
        let timeStr = container.codingPath.last?.stringValue ?? ""
        self.dateStr = timeStr
        dictionary = dit
    }

    /// The key against which market cap data is stored.
    var marketCapKey: String? {
        guard let marketCapKey = (self.dictionary.keys.filter { $0.contains("market cap") }).first else {
            return nil
        }
        return marketCapKey
    }

    /// The value in `Double` for the market cap
    var marketCapValue: Double {
        guard let marketCapKey = self.marketCapKey else { return 0.0 }
        guard let marketCapValue = self.dictionary[marketCapKey] else { return 0.0 }
        return Double(marketCapValue) ?? 0.0
    }
}
