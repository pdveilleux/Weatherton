//
//  Dependencies.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/25/24.
//

import Foundation
import SwiftData

class DependencyJar: ObservableObject {
    let weatherRepository: WeatherRepository
    let weatherService: WeatherService
    let persistenceController: PersistenceController
    let preferenceManager: PreferenceManager
    let modelContainer: ModelContainer
    let temperatureFormatter: MeasurementFormatter
    
    init(
        weatherRepository: WeatherRepository,
        weatherService: WeatherService,
        persistenceController: PersistenceController,
        preferenceManager: PreferenceManager,
        modelContainer: ModelContainer,
        temperatureFormatter: MeasurementFormatter
    ) {
        self.weatherRepository = weatherRepository
        self.weatherService = weatherService
        self.persistenceController = persistenceController
        self.preferenceManager = preferenceManager
        self.modelContainer = modelContainer
        self.temperatureFormatter = temperatureFormatter
    }
}

@MainActor
class DependencyBuilder {
    func build() -> DependencyJar {
        let modelContainer = {
            let schema = Schema([
                CurrentWeatherPersistenceModel.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()

        let weatherService = WeatherAPIClient()
        let preferenceManager = DefaultPreferenceManager()
        let persistenceController = DefaultPersistenceController(modelContainer: modelContainer)
        let weatherRepository = DefaultWeatherRepository(
            weatherService: weatherService,
            persistenceController: persistenceController,
            preferenceManager: preferenceManager
        )

        let temperatureFormatter: MeasurementFormatter = {
            var formatter = MeasurementFormatter()
            formatter.numberFormatter.maximumFractionDigits = 0
            formatter.unitStyle = .short
            return formatter
        }()
        
        return DependencyJar(
            weatherRepository: weatherRepository,
            weatherService: weatherService,
            persistenceController: persistenceController,
            preferenceManager: preferenceManager,
            modelContainer: modelContainer,
            temperatureFormatter: temperatureFormatter
        )
    }
}
