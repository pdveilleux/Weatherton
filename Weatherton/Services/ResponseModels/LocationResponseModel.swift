//
//  LocationResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

struct LocationResponseModel: Codable {
    /// The location name, typically a city.
    let name: String
    /// The greater region of the location.
    let region: String
    /// The location's country.
    let country: String
    /// The location's latitude.
    let lat: Double
    /// The location's longitude.
    let lon: Double
}

extension LocationResponseModel {
    func convertToLocation() -> Location {
        Weatherton.Location(
            name: name,
            region: region,
            country: country,
            latitude: lat,
            longitude: lon
        )
    }
}
