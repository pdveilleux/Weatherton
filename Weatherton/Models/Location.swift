//
//  Location.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/22/24.
//

import Foundation

struct Location: Hashable {
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
}
