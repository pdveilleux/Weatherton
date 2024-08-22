//
//  WeathertonApp.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import SwiftUI
import SwiftData

@main
struct WeathertonApp: App {
    var sharedModelContainer: ModelContainer = {
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

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootWeatherView(
                    viewModel: RootWeatherViewModel(
                        weatherRepository: DefaultWeatherRepository(
                            weatherService: WeatherAPIClient(),
                            persistenceController: DefaultPersistenceController(
                                modelContainer: sharedModelContainer
                            )
                        )
                    )
                )
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
