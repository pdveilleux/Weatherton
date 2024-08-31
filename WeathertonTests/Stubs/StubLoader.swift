//
//  StubLoader.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/30/24.
//

import Foundation

class StubLoader {
    enum Error: Swift.Error {
        case missingFile
    }

    func jsonDataFor(filename: String) throws -> Data {
        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw Error.missingFile
        }
        return try Data(contentsOf: url)
    }
}
