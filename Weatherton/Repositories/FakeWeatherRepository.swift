//
//  FakeWeatherRepository.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/25/24.
//

#if DEBUG
import Foundation

@MainActor
final class FakeWeatherRepository: WeatherRepository {
    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        CurrentWeather(
            apparentTemperature: Measurement(value: 24.1, unit: .celsius),
            dewPoint: Measurement(value: 10.7, unit: .celsius),
            humidity: 36,
            temperature: Measurement(value: 28.5, unit: .celsius),
            updatedDate: .now - (60 * 10),
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

    func getCurrentWeatherForSavedLocations() async throws -> [CurrentWeather] {
        []
    }

    func searchLocations(query: String) async throws -> [Location] {
        []
    }
}
#endif
