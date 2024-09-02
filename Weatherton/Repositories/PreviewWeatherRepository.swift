//
//  PreviewWeatherRepository.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/25/24.
//

#if DEBUG
import Foundation

@MainActor
final class PreviewWeatherRepository: WeatherRepository {
    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        PreviewData.CurrentWeather.london
    }

    func getCurrentWeatherForSavedLocations() async throws -> [CurrentWeather] {
        [PreviewData.CurrentWeather.london, PreviewData.CurrentWeather.minneapolis]
    }

    func getForecast(location: Location) async throws -> Forecast {
        PreviewData.Forecast.minneapolis
    }

    func searchLocations(query: String) async throws -> [Location] {
        [PreviewData.Location.cupertino]
    }
}
#endif
