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
        PreviewData.CurrentWeather.london
    }

    func getCurrentWeatherForSavedLocations() async throws -> [CurrentWeather] {
        [PreviewData.CurrentWeather.london, PreviewData.CurrentWeather.minneapolis]
    }

    func searchLocations(query: String) async throws -> [Location] {
        []
    }
}
#endif
