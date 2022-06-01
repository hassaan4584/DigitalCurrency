//
//  UnitTestUtils.swift
//  HiTests
//
//  Created by Hassaan Fayyaz Ahmed on 5/31/22.
//

import Foundation

final class UnitTestUtils {

    /// Get Json data from given filename
    /// - Parameter fileName: The `fileName`.json file from which json data is to be read
    /// - Returns: When the file is correctly found, return its contents in `Data` form
    static func getCurrencyData(from fileName: String) -> Data? {
        
        let bundle = Bundle(for: type(of: UnitTestUtils().self))
        guard let bundleUrl = bundle.url(forResource: fileName, withExtension: "json"), let jsonData = try? Data(contentsOf: bundleUrl) else {
            return nil
        }
        return jsonData
    }

}
