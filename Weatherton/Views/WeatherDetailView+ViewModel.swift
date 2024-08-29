//
//  WeatherDetailView+ViewModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

extension WeatherDetailView {
    @Observable @MainActor
    final class ViewModel {
        private(set) var currentWeather: FormattedCurrentWeather
        private(set) var forecast: Forecast?
        var location: Location {
            currentWeather.location
        }

        private let weatherRepository: WeatherRepository
        private let temperatureFormatter: MeasurementFormatter

        init(
            currentWeather: CurrentWeather,
            forecast: Forecast? = nil,
            weatherRepository: WeatherRepository,
            temperatureFormatter: MeasurementFormatter
        ) {
            self.currentWeather = FormattedCurrentWeather(currentWeather: currentWeather, formatter: temperatureFormatter)
            self.forecast = forecast
            self.weatherRepository = weatherRepository
            self.temperatureFormatter = temperatureFormatter
        }

        func getForecast() async {
            do {
                forecast = try await weatherRepository.getForecast(location: location)
            } catch {
                print("Error fetching forecast: \(error)")
            }
        }
    }
}
