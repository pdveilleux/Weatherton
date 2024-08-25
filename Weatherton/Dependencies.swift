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
    
    init(
        weatherRepository: WeatherRepository,
        weatherService: WeatherService,
        persistenceController: PersistenceController,
        preferenceManager: PreferenceManager,
        modelContainer: ModelContainer
    ) {
        self.weatherRepository = weatherRepository
        self.weatherService = weatherService
        self.persistenceController = persistenceController
        self.preferenceManager = preferenceManager
        self.modelContainer = modelContainer
    }
}

@MainActor
class DependencyBuilder {
    func build() -> DependencyJar {
        let modelContainer = {
            let schema = Schema([
                Item.self,
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
        
        return DependencyJar(
            weatherRepository: weatherRepository,
            weatherService: weatherService,
            persistenceController: persistenceController,
            preferenceManager: preferenceManager,
            modelContainer: modelContainer
        )
    }
}
