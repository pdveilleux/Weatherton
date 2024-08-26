//
//  PersistenceController.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation
import SwiftData

protocol PersistenceController {
    func getCurrentWeather(location: Location) async throws -> CurrentWeather
    func storeCurrentWeather(_ currentWeather: CurrentWeather) async
}

struct PersistenceControllerError: Error {
    
}

@MainActor
final class DefaultPersistenceController: PersistenceController {
    private let modelContainer: ModelContainer

    enum Constants {
        static let fifteenMinutes = TimeInterval(60 * 15)
    }

    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }

    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        do {
            let locationModel = try getLocationPersistenceModel(location)
            let latitude = locationModel.latitude
            let longitude = locationModel.longitude
            
            let fifteenMinutesAgo = Date.now - Constants.fifteenMinutes
            var descriptor = FetchDescriptor<CurrentWeatherPersistenceModel>(predicate: #Predicate<CurrentWeatherPersistenceModel> { weather in
                if weather.updatedDate > fifteenMinutesAgo {
                    if let location = weather.location {
                        if location.latitude == latitude && location.longitude == longitude {
                            return true
                        } else {
                            return false
                        }
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            })
            descriptor.fetchLimit = 1
            descriptor.sortBy = [SortDescriptor(\.updatedDate, order: .reverse)]
            
            guard let result = try modelContainer.mainContext.fetch(descriptor).first else {
                throw PersistenceControllerError()
            }
            return result.convertToCurrentWeather()
        } catch {
            throw PersistenceControllerError()
        }
    }

    func storeCurrentWeather(_ currentWeather: CurrentWeather) async {
        let model = CurrentWeatherPersistenceModel(currentWeather: currentWeather)
        if let locationModel = try? getLocationPersistenceModel(currentWeather.location) {
            model.location = locationModel
        } else {
            model.location = storeLocation(currentWeather.location)
        }
        modelContainer.mainContext.insert(model)
    }

    private func getLocationPersistenceModel(_ location: Location) throws -> LocationPersistenceModel {
        var descriptor = FetchDescriptor(predicate: #Predicate<LocationPersistenceModel> { item in
            location.latitude == item.latitude && location.longitude == item.longitude
        })
        descriptor.fetchLimit = 1

        do {
            guard let result = try modelContainer.mainContext.fetch(descriptor).first else {
                throw PersistenceControllerError()
            }
            return result
        } catch {
            throw PersistenceControllerError()
        }
    }

    @discardableResult
    private func storeLocation(_ location: Location) -> LocationPersistenceModel {
        let model = LocationPersistenceModel(location: location)
        modelContainer.mainContext.insert(model)
        return model
    }
}
