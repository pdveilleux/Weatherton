//
//  Location.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/22/24.
//

import Foundation

struct Location: Hashable, Codable {
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

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension Location {
    static let minneapolis = Location(
        name: "Minneapolis",
        region: "Minnesota",
        country: "United States of America",
        latitude: 44.98,
        longitude: -93.26
    )
    static let london = Location(
        name: "London",
        region: "City of London, Greater London",
        country: "United Kingdom",
        latitude: 51.52,
        longitude: -0.11
    )
    static let tokyo = Location(
        name: "Tokyo",
        region: "Tokyo",
        country: "Japan",
        latitude: 35.69,
        longitude: 139.69
    )
    static let saoPaulo = Location(
        name: "Sao Paulo",
        region: "Sao Paulo",
        country: "Brazil",
        latitude: -23.53,
        longitude: -46.62
    )
    static let nairobi = Location(
        name: "Nairobi",
        region: "Nairobi Area",
        country: "Kenya",
        latitude: -1.28,
        longitude: 36.82
    )
    static let hongKong = Location(
        name: "Hong Kong",
        region: "",
        country: "Hong Kong",
        latitude: 22.28,
        longitude: 114.15
    )
}
