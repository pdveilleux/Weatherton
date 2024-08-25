//
//  WeatherRepository.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

protocol WeatherRepository {
    func getCurrentWeather(location: Location) async throws -> CurrentWeather
    func getCurrentWeatherForSavedLocations() async throws -> [CurrentWeather]
    func searchLocations(query: String) async throws -> [Location]
}

struct WeatherRepositoryError: Error {
    
}

final class DefaultWeatherRepository: WeatherRepository {
    private let weatherService: WeatherService
    private let persistenceController: PersistenceController
    private let preferenceManager: PreferenceManager

    init(weatherService: WeatherService, persistenceController: PersistenceController, preferenceManager: PreferenceManager) {
        self.weatherService = weatherService
        self.persistenceController = persistenceController
        self.preferenceManager = preferenceManager
    }
    
    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        guard let currentWeather = try? await persistenceController.getCurrentWeather() else {
            return try await weatherService.getCurrentWeather(query: location.name)
        }
        return currentWeather
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
            weather.sort { (a, b) -> Bool in
                guard let first = locations.firstIndex(of: a.location) else { return false }
                guard let second = locations.firstIndex(of: b.location) else { return true }
                return first < second
            }
            return weather
        }
    }

    func searchLocations(query: String) async throws -> [Location] {
        try await weatherService.searchLocations(query: query)
    }
}
