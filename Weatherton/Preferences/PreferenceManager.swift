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
    func removeSavedLocations(_ locations: [Location]) async
    func setupFirstTimeLaunchIfNeeded() async
}

@MainActor
final class DefaultPreferenceManager: PreferenceManager {
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let store: UserDefaults

    private enum Key {
        case savedLocations
        case firstTimeLaunch

        var name: String {
            switch self {
            case .savedLocations: "SavedLocations"
            case .firstTimeLaunch: "FirstTimeLaunch"
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

    func setupFirstTimeLaunchIfNeeded() async {
        let hasSetupFirstTimeLaunch = store.bool(forKey: Key.firstTimeLaunch.name)
        guard !hasSetupFirstTimeLaunch else {
            return
        }

        let locations = [
            Location(
                name: "Minneapolis",
                region: "Minnesota",
                country: "United States of America",
                latitude: 44.98,
                longitude: -93.26
            ),
            Location(
                name: "London",
                region: "City of London, Greater London",
                country: "United Kingdom",
                latitude: 51.52,
                longitude: -0.11
            ),
            Location(
                name: "Tokyo",
                region: "Tokyo",
                country: "Japan",
                latitude: 35.69,
                longitude: 139.69
            ),
            Location(
                name: "Sao Paulo",
                region: "Sao Paulo",
                country: "Brazil",
                latitude: -23.53,
                longitude: -46.62
            ),
            Location(
                name: "Nairobi",
                region: "Nairobi Area",
                country: "Kenya",
                latitude: -1.28,
                longitude: 36.82
            ),
            Location(
                name: "Hong Kong",
                region: "",
                country: "Hong Kong",
                latitude: 22.28,
                longitude: 114.15
            ),
        ]
        setValue(locations, forKey: .savedLocations)
        store.set(true, forKey: Key.firstTimeLaunch.name)
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
