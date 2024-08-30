//
//  DependencyBuilder.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation
import SwiftData

@MainActor
class DependencyBuilder {
    func build() -> DependencyJar {
        let weatherService = WeatherAPIClient()
        let preferenceManager = DefaultPreferenceManager()
        let weatherRepository = DefaultWeatherRepository(
            weatherService: weatherService,
            preferenceManager: preferenceManager
        )

        let temperatureFormatter: MeasurementFormatter = {
            let formatter = MeasurementFormatter()
            formatter.numberFormatter.maximumFractionDigits = 0
            formatter.unitStyle = .short
            return formatter
        }()

        let viewModelFactory = ViewModelFactory(
            weatherRepository: weatherRepository,
            preferenceManager: preferenceManager,
            temperatureFormatter: temperatureFormatter
        )
        
        return DependencyJar(
            viewModelFactory: viewModelFactory,
            weatherRepository: weatherRepository,
            weatherService: weatherService,
            preferenceManager: preferenceManager,
            temperatureFormatter: temperatureFormatter
        )
    }
}
