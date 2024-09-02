//
//  WeatherRepository.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

/// An interface that coordinates the retrieval of data from the underlying weather service and persistence layers.
protocol WeatherRepository {
    /// Retrieves the current weather for a given location.
    func getCurrentWeather(location: Location) async throws -> CurrentWeather

    /// Retrieves the current weather for the user's saved locations.
    ///
    /// The `WeatherRepository` will get the saved locations from the `PreferenceManager` and fetch 
    /// their current weather. The results will be sorted according to the order of the saved locations.
    func getCurrentWeatherForSavedLocations() async throws -> [CurrentWeather]

    /// Retrieves the forecast for a given location.
    func getForecast(location: Location) async throws -> Forecast

    /// Provides possible matching locations based on the search query.
    func searchLocations(query: String) async throws -> [Location]
}
