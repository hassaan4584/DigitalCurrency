//
//  DigitalCurrencyMetadata.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
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

struct DigitalCurrencyMetadata: Codable {
    let information, digitalCurrencyCode, the3DigitalCurrencyName, the4MarketCode: String
    let the5MarketName, the6LastRefreshed, the7TimeZone: String

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case digitalCurrencyCode = "2. Digital Currency Code"
        case the3DigitalCurrencyName = "3. Digital Currency Name"
        case the4MarketCode = "4. Market Code"
        case the5MarketName = "5. Market Name"
        case the6LastRefreshed = "6. Last Refreshed"
        case the7TimeZone = "7. Time Zone"
    }
}


// MARK: - TimeSeriesDigitalCurrencyDaily
struct TimeSeriesDigitalCurrencyDaily: Codable {
    
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
    
//    let the1AOpenUSD, the1BOpenUSD, the2AHighUSD, the2BHighUSD: String
//    let the3ALowUSD, the3BLowUSD, the4ACloseUSD, the4BCloseUSD: String
//    let the5Volume, the6MarketCapUSD: String
//
//    enum CodingKeys: String, CodingKey {
//        case the1AOpenUSD = "1a. open (USD)"
//        case the1BOpenUSD = "1b. open (USD)"
//        case the2AHighUSD = "2a. high (USD)"
//        case the2BHighUSD = "2b. high (USD)"
//        case the3ALowUSD = "3a. low (USD)"
//        case the3BLowUSD = "3b. low (USD)"
//        case the4ACloseUSD = "4a. close (USD)"
//        case the4BCloseUSD = "4b. close (USD)"
//        case the5Volume = "5. volume"
//        case the6MarketCapUSD = "6. market cap (USD)"
//    }
}
