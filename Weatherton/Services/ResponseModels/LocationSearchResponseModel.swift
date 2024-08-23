//
//  LocationSearchResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/22/24.
//

import Foundation

struct LocationSearchResponseModel: Codable {
    /// The unique ID for the location, specific to WeatherAPI.
    let id: Int
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

extension LocationSearchResponseModel {
    func convertToLocation() -> Location {
        Location(
            name: name,
            region: region,
            country: country,
            latitude: lat,
            longitude: lon
        )
    }
}
