//
//  PreferenceManager.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/24/24.
//

import Foundation

protocol PreferenceManager {
    func saveLocation(_ location: Location) async
    func getSavedLocations() async -> [Location]
}

@MainActor
final class DefaultPreferenceManager: PreferenceManager {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let store = UserDefaults.standard

    private enum Key {
        case savedLocations

        var name: String {
            switch self {
            case .savedLocations: "SavedLocations"
            }
        }
    }

    func saveLocation(_ location: Location) {
        guard var locations = getType([Location].self, forKey: .savedLocations) else {
            setValue([location], forKey: .savedLocations)
            return
        }
        locations.append(location)
        setValue(locations, forKey: .savedLocations)
    }

    func getSavedLocations() -> [Location] {
        guard let locations = getType([Location].self, forKey: .savedLocations) else {
            return []
        }
        return locations
    }
}

extension DefaultPreferenceManager {
    private func getType<T>(_ type: T.Type, forKey key: Key) -> T? where T: Decodable {
        guard
            let savedData = store.data(forKey: key.name),
            let result = try? decoder.decode(type, from: savedData)
        else {
            return nil
        }
        return result
    }

    private func setValue(_ value: Encodable, forKey key: Key) {
        guard let data = try? encoder.encode(value) else {
            return
        }
        store.setValue(data, forKey: key.name)
    }
}
