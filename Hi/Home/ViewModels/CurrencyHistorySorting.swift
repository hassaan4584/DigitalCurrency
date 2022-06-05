//
//  CurrencyHistorySorting.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 6/5/22.
//

import Foundation

enum CurrencyHistorySorting: String {
    case dateAscending
    case dateDescending
    case marketCapAscending
    case marketCapDescending

    /// Name to be shown in the text field
    var sortingName: String {
        switch self {
        case .dateAscending:
            return "Sort by Date - Ascending"
        case .dateDescending:
            return "Sort by Date - Descending"
        case .marketCapAscending:
            return "Sort by Market Cap - Ascending"
        case .marketCapDescending:
            return "Sort by Market Cap - Descending"
        }
    }
}
