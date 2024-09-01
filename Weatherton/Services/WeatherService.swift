//
//  WeatherService.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

protocol WeatherService {
    func getCurrentWeather(location: Location) async throws -> CurrentWeather
    func getForecast(location: Location) async throws -> Forecast
    func searchLocations(query: String) async throws -> [Location]
}

enum WeatherServiceError: Error {
    case generic
    case notConnectedToInternet
}
