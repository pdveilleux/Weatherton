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
    let updatedDate: Date
    let condition: WeatherCondition
    let location: Location
}
