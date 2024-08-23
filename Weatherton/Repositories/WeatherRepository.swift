//
//  WeatherRepository.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

protocol WeatherRepository {
    func getCurrentWeather(query: String) async throws -> CurrentWeather
    func searchLocations(query: String) async throws -> [Location]
}

struct WeatherRepositoryError: Error {
    
}

final class DefaultWeatherRepository: WeatherRepository {
    private let weatherService: WeatherService
    private let persistenceController: PersistenceController

    init(weatherService: WeatherService, persistenceController: PersistenceController) {
        self.weatherService = weatherService
        self.persistenceController = persistenceController
    }
    
    func getCurrentWeather(query: String) async throws -> CurrentWeather {
        guard let currentWeather = try? await persistenceController.getCurrentWeather() else {
            return try await weatherService.getCurrentWeather(query: query)
        }
        return currentWeather
    }

    func searchLocations(query: String) async throws -> [Location] {
        try await weatherService.searchLocations(query: query)
    }
}

#if DEBUG
@MainActor
final class FakeWeatherRepository: WeatherRepository {
    func getCurrentWeather(query: String) async throws -> CurrentWeather {
        CurrentWeather(
            apparentTemperature: Measurement(value: 24.1, unit: .celsius),
            dewPoint: Measurement(value: 10.7, unit: .celsius),
            humidity: 36,
            temperature: Measurement(value: 28.5, unit: .celsius),
            condition: WeatherCondition(
                description: "Partly Cloudy",
                systemImage: "cloud.sun"
            ),
            location: Weatherton.Location(
                name: "London",
                region: "City of London, Greater London",
                country: "United Kingdom",
                latitude: 51.52,
                longitude: -0.11)
        )
    }

    func searchLocations(query: String) async throws -> [Location] {
        []
    }
}
#endif
