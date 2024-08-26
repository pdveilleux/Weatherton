//
//  LocationPersistenceModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/25/24.
//

import Foundation
import SwiftData

@Model
final class LocationPersistenceModel {
    /// The location name, typically a city.
    let name: String
    /// The greater region of the location.
    let region: String
    /// The location's country.
    let country: String
    /// The location's latitude.
    let latitude: Double
    /// The location's longitude.
    let longitude: Double

    var weather: [CurrentWeatherPersistenceModel]

    init(location: Location) {
        name = location.name
        region = location.region
        country = location.country
        latitude = location.latitude
        longitude = location.latitude
        weather = []
    }
}

extension LocationPersistenceModel: Equatable {
    static func == (lhs: LocationPersistenceModel, rhs: LocationPersistenceModel) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
