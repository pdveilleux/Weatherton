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
            persistenceController: persistenceController,
            preferenceManager: preferenceManager,
            modelContainer: modelContainer,
            temperatureFormatter: temperatureFormatter
        )
    }
}
