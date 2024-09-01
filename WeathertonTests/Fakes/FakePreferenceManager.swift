//
//  FakePreferenceManager.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/31/24.
//

import Foundation
@testable import Weatherton

final class FakePreferenceManager: PreferenceManager {
    var getSavedLocationsResponse: [Location]?

    func saveLocation(_ location: Location) async {}
    
    func getSavedLocations() async -> [Location] {
        guard let getSavedLocationsResponse else {
            preconditionFailure("FakePreferenceManager must have getSavedLocationsResponse set before calling getSavedLocations.")
        }
        return getSavedLocationsResponse
    }
    
    func removeSavedLocations(_ locations: [Location]) async {}
}
