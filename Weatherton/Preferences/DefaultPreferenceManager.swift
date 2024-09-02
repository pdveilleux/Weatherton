//
//  DefaultPreferenceManager.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 9/2/24.
//

import Foundation

@MainActor
final class DefaultPreferenceManager: PreferenceManager {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let store: UserDefaults

    private enum Key {
        case savedLocations
        case hasConfiguredDefaultLocations

        var name: String {
            switch self {
            case .savedLocations: "SavedLocations"
            case .hasConfiguredDefaultLocations: "HasConfiguredDefaultLocations"
            }
        }
    }

    init(store: UserDefaults = .standard) {
        self.store = store
    }

    func saveLocation(_ location: Location) {
        var locations = getSavedLocations()
        locations.append(location)
        setValue(locations, forKey: .savedLocations)
    }

    func getSavedLocations() -> [Location] {
        guard let locations = getType([Location].self, forKey: .savedLocations) else {
            return []
        }
        return locations
    }

    func removeSavedLocations(_ locations: [Location]) {
        var savedLocations = getSavedLocations()
        locations.forEach { location in
            savedLocations.removeAll(where: { $0 == location })
        }
        setValue(savedLocations, forKey: .savedLocations)
    }

    func setupDefaultLocationsIfNeeded() async {
        let hasSetupFirstTimeLaunch = store.bool(forKey: Key.hasConfiguredDefaultLocations.name)
        guard !hasSetupFirstTimeLaunch else {
            return
        }

        let locations: [Location] = [
            .minneapolis,
            .london,
            .tokyo,
            .saoPaulo,
            .nairobi,
            .hongKong
        ]
        setValue(locations, forKey: .savedLocations)
        store.set(true, forKey: Key.hasConfiguredDefaultLocations.name)
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
