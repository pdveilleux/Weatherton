//
//  CurrentWeather.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

struct CurrentWeather: Hashable, Identifiable {
    let id: UUID
    let apparentTemperature: Measurement<UnitTemperature>
    let dewPoint: Measurement<UnitTemperature>
    let humidity: Int
    let temperature: Measurement<UnitTemperature>
    let visibility: Measurement<UnitLength>
    let windSpeed: Measurement<UnitSpeed>
    let windDirection: String
    let updatedDate: Date
    let description: String
    let systemImage: String?
    let location: Location
}
