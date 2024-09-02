//
//  PreferenceManager.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/24/24.
//

import Foundation

/// An interface to save user preferences across app launches.
protocol PreferenceManager {
    /// Saves a location.
    func saveLocation(_ location: Location) async
    /// Fetches the saved locations.
    func getSavedLocations() async -> [Location]
    /// Removes an array of locations from those that are saved.
    func removeSavedLocations(_ locations: [Location]) async
    /// Configures the default locations if the user has not launched the app before.
    func setupDefaultLocationsIfNeeded() async
}
