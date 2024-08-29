//
//  ViewModelFactory.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

@MainActor
final class ViewModelFactory {
    private let weatherRepository: WeatherRepository
    private let preferenceManager: PreferenceManager
    private let temperatureFormatter: MeasurementFormatter

    init(
        weatherRepository: WeatherRepository,
        preferenceManager: PreferenceManager,
        temperatureFormatter: MeasurementFormatter
    ) {
        self.weatherRepository = weatherRepository
        self.preferenceManager = preferenceManager
        self.temperatureFormatter = temperatureFormatter
    }

    func buildRootWeatherViewModel() -> RootWeatherView.ViewModel {
        RootWeatherView.ViewModel(
            weatherRepository: weatherRepository,
            preferenceManager: preferenceManager,
            temperatureFormatter: temperatureFormatter
        )
    }

    func buildWeatherDetailViewModel(currentWeather: CurrentWeather) -> WeatherDetailView.ViewModel {
        WeatherDetailView.ViewModel(
            currentWeather: currentWeather,
            weatherRepository: weatherRepository,
            temperatureFormatter: temperatureFormatter
        )
    }
}
