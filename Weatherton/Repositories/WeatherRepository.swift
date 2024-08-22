//
//  WeatherRepository.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

protocol WeatherRepository {
    func getCurrentWeather() async throws -> CurrentWeather
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
    
    func getCurrentWeather() async throws -> CurrentWeather {
        guard let currentWeather = try? await persistenceController.getCurrentWeather() else {
            return try await weatherService.getCurrentWeather(query: "55410")
        }
        return currentWeather
    }
}

#if DEBUG
@MainActor
final class FakeWeatherRepository: WeatherRepository {
    func getCurrentWeather() async throws -> CurrentWeather {
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
                name: "Minneapolis",
                region: "Minnesota",
                country: "USA",
                latitude: 44.91,
                longitude: -93.32)
        )
    }
}
#endif
