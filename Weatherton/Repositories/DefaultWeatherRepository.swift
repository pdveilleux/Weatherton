//
//  DefaultWeatherRepository.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/31/24.
//

import Foundation

final class DefaultWeatherRepository: WeatherRepository {
    private let weatherService: WeatherService
    private let preferenceManager: PreferenceManager

    init(weatherService: WeatherService, preferenceManager: PreferenceManager) {
        self.weatherService = weatherService
        self.preferenceManager = preferenceManager
    }

    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        try await weatherService.getCurrentWeather(location: location)
    }

    func getCurrentWeatherForSavedLocations() async throws -> [CurrentWeather] {
        try await withThrowingTaskGroup(of: CurrentWeather.self) { taskGroup in
            let locations = await preferenceManager.getSavedLocations()
            for location in locations {
                taskGroup.addTask {
                    try await self.getCurrentWeather(location: location)
                }
            }

            var weather = [CurrentWeather]()
            for try await result in taskGroup {
                weather.append(result)
            }

            weather.sort { (lhs, rhs) -> Bool in
                guard let first = locations.firstIndex(of: lhs.location) else { return false }
                guard let second = locations.firstIndex(of: rhs.location) else { return true }
                return first < second
            }
            return weather
        }
    }

    func getForecast(location: Location) async throws -> Forecast {
        try await weatherService.getForecast(location: location)
    }

    func searchLocations(query: String) async throws -> [Location] {
        try await weatherService.searchLocations(query: query)
    }
}
