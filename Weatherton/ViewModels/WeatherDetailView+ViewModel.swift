//
//  WeatherDetailView+ViewModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation
import OSLog

extension WeatherDetailView {
    @Observable @MainActor
    final class ViewModel {
        private(set) var isLoading = false
        private(set) var errorMessage: Message?
        private(set) var currentWeather: FormattedCurrentWeather
        private(set) var forecast: FormattedForecast?
        var location: Location {
            currentWeather.location
        }

        private let weatherRepository: WeatherRepository
        private let temperatureFormatter: MeasurementFormatter
        private let logger: Logger

        init(
            currentWeather: CurrentWeather,
            forecast: Forecast? = nil,
            weatherRepository: WeatherRepository,
            temperatureFormatter: MeasurementFormatter,
            logger: Logger
        ) {
            self.currentWeather = FormattedCurrentWeather(currentWeather: currentWeather, formatter: temperatureFormatter)
            self.weatherRepository = weatherRepository
            self.temperatureFormatter = temperatureFormatter
            self.logger = logger

            if let forecast {
                self.forecast = FormattedForecast(forecast: forecast, formatter: temperatureFormatter)
            }
        }

        func getForecast() async {
            isLoading = true
            defer {
                isLoading = false
            }

            do {
                let forecast = try await weatherRepository.getForecast(location: location)
                self.forecast = FormattedForecast(forecast: forecast, formatter: temperatureFormatter)
                errorMessage = nil
            } catch WeatherServiceError.notConnectedToInternet {
                errorMessage = .notConnectedToInternet
            } catch {
                logger.log(level: .error, "Error fetching forecast: \(error)")
            }
        }
    }
}
