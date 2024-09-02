//
//  WeatherService.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

/// An interface to the underlying weather API.
protocol WeatherService {
    /// Retrieves the current weather for a given location.
    func getCurrentWeather(location: Location) async throws -> CurrentWeather

    /// Retrieves the forecast for a given location.
    func getForecast(location: Location) async throws -> Forecast

    /// Provides possible matching locations based on the search query.
    func searchLocations(query: String) async throws -> [Location]
}

/// A type representing various errors when interfacing with the `WeatherService`.
enum WeatherServiceError: Error {
    /// A catch-all error when more specific details are not, or should not, be provided.
    case generic
    /// There appears to be no connection to the internet.
    case notConnectedToInternet
}
