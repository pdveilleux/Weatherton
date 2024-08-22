//
//  CurrentWeather.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

struct CurrentWeather: Hashable {
    let apparentTemperature: Measurement<UnitTemperature>
    let dewPoint: Measurement<UnitTemperature>
    let humidity: Int
    let temperature: Measurement<UnitTemperature>
    let condition: WeatherCondition
    let location: Location
}

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

struct WeatherCondition: Hashable {
    /// Weather condition description.
    let description: String
    /// The name of the system symbol which represents the condition.
    let systemImage: String?
}
