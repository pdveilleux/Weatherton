//
//  Forecast.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

struct Forecast {
    let location: Location
    let days: [ForecastDay]
}

struct ForecastDay {
    let date: Date
    let maxTemp: Measurement<UnitTemperature>
    let minTemp: Measurement<UnitTemperature>
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
    let condition: WeatherCondition
    let uv: Double
    let hours: [Hour]
}

extension ForecastDay {
    struct Hour {
        let time: Date
        let apparentTemperature: Measurement<UnitTemperature>
        let dewPoint: Measurement<UnitTemperature>
        let humidity: Int
        let temperature: Measurement<UnitTemperature>
        let condition: WeatherCondition
    }
}
