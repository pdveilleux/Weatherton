//
//  Dependencies.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/25/24.
//

import Foundation
import SwiftData

class DependencyJar: ObservableObject {
    let viewModelFactory: ViewModelFactory
    let weatherRepository: WeatherRepository
    let weatherService: WeatherService
    let preferenceManager: PreferenceManager
    let temperatureFormatter: MeasurementFormatter
    
    init(
        viewModelFactory: ViewModelFactory,
        weatherRepository: WeatherRepository,
        weatherService: WeatherService,
        preferenceManager: PreferenceManager,
        temperatureFormatter: MeasurementFormatter
    ) {
        self.viewModelFactory = viewModelFactory
        self.weatherRepository = weatherRepository
        self.weatherService = weatherService
        self.preferenceManager = preferenceManager
        self.temperatureFormatter = temperatureFormatter
    }
}
