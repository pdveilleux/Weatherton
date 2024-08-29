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
    let persistenceController: PersistenceController
    let preferenceManager: PreferenceManager
    let modelContainer: ModelContainer
    let temperatureFormatter: MeasurementFormatter
    
    init(
        viewModelFactory: ViewModelFactory,
        weatherRepository: WeatherRepository,
        weatherService: WeatherService,
        persistenceController: PersistenceController,
        preferenceManager: PreferenceManager,
        modelContainer: ModelContainer,
        temperatureFormatter: MeasurementFormatter
    ) {
        self.viewModelFactory = viewModelFactory
        self.weatherRepository = weatherRepository
        self.weatherService = weatherService
        self.persistenceController = persistenceController
        self.preferenceManager = preferenceManager
        self.modelContainer = modelContainer
        self.temperatureFormatter = temperatureFormatter
    }
}
