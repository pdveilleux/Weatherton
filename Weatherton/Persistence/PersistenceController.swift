//
//  PersistenceController.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation
import SwiftData

protocol PersistenceController {
    func getCurrentWeather() async throws -> CurrentWeather
    func storeCurrentWeather(_ currentWeather: CurrentWeather) async
}

struct PersistenceControllerError: Error {
    
}

@MainActor
final class DefaultPersistenceController: PersistenceController {
    private let modelContainer: ModelContainer

    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }

    func getCurrentWeather() async throws -> CurrentWeather {
        throw PersistenceControllerError()
    }

    func storeCurrentWeather(_ currentWeather: CurrentWeather) async {
        
    }
}

@Model
class CurrentWeatherPersistenceModel {
    
    init(currentWeather: CurrentWeather) {
        
    }
}
