//
//  WeathertonApp.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import SwiftUI

@main
struct WeathertonApp: App {
    @StateObject var dependencyJar: DependencyJar = DependencyBuilder().build()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootWeatherView(viewModel: dependencyJar.viewModelFactory.buildRootWeatherViewModel())
                    .environmentObject(dependencyJar)
            }
            .task {
                await dependencyJar.preferenceManager.setupDefaultLocationsIfNeeded()
            }
        }
    }
}
