//
//  FakeUserDefaults.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/30/24.
//

import Foundation

final class FakeUserDefaults: UserDefaults {
    var dataForKeyResponse: Data?
    var setValueForKeyInput: SetValueForKeyInput?

    struct SetValueForKeyInput {
        let value: Any?
        let key: String
    }
    
    override func data(forKey defaultName: String) -> Data? {
        dataForKeyResponse
    }

    override func setValue(_ value: Any?, forKey key: String) {
        setValueForKeyInput = SetValueForKeyInput(value: value, key: key)
    }
}
