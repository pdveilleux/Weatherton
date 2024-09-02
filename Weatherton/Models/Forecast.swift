//
//  Forecast.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

struct Forecast: Hashable {
    let location: Location
    let days: [ForecastDay]
}

struct ForecastDay: Hashable {
    let date: Date
    let maxTemperature: Measurement<UnitTemperature>
    let minTemperature: Measurement<UnitTemperature>
    let averageTemperature: Measurement<UnitTemperature>
    let maxWind: Measurement<UnitSpeed>
    let totalPrecipitation: Measurement<UnitLength>
    let totalSnow: Measurement<UnitLength>
    let averageVisibility: Measurement<UnitLength>
    let averageHumidity: Int
    let dailyWillItRain: Bool
    let dailyChanceOfRain: Int
    let dailyWillItSnow: Bool
    let dailyChanceOfSnow: Int
    let description: String
    let systemImage: String?
    let uvIndex: Double
    let hours: [Hour]
}

extension ForecastDay {
    struct Hour: Hashable {
        let time: Date
        let apparentTemperature: Measurement<UnitTemperature>
        let dewPoint: Measurement<UnitTemperature>
        let humidity: Int
        let temperature: Measurement<UnitTemperature>
        let description: String
        let systemImage: String?
    }
}
