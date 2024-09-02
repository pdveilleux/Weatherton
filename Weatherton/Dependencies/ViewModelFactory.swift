//
//  ViewModelFactory.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation
import OSLog

@MainActor
final class ViewModelFactory {
    private let weatherRepository: WeatherRepository
    private let preferenceManager: PreferenceManager
    private let temperatureFormatter: MeasurementFormatter
    private let logger: Logger

    init(
        weatherRepository: WeatherRepository,
        preferenceManager: PreferenceManager,
        temperatureFormatter: MeasurementFormatter,
        logger: Logger
    ) {
        self.weatherRepository = weatherRepository
        self.preferenceManager = preferenceManager
        self.temperatureFormatter = temperatureFormatter
        self.logger = logger
    }

    func buildRootWeatherViewModel() -> RootWeatherView.ViewModel {
        RootWeatherView.ViewModel(
            weatherRepository: weatherRepository,
            preferenceManager: preferenceManager,
            temperatureFormatter: temperatureFormatter, 
            logger: logger
        )
    }

    func buildWeatherDetailViewModel(currentWeather: CurrentWeather) -> WeatherDetailView.ViewModel {
        WeatherDetailView.ViewModel(
            currentWeather: currentWeather,
            weatherRepository: weatherRepository,
            temperatureFormatter: temperatureFormatter, 
            logger: logger
        )
    }
}
