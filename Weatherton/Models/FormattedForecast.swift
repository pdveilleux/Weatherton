//
//  FormattedForecast.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/29/24.
//

import Foundation

struct FormattedForecast: Hashable {
    var location: Location {
        backingData.location
    }
    let days: [FormattedForecastDay]

    var minimimMinTemp: Double? {
        backingData.days.map(\.minTemperature).min()?.value
    }
    var maximumMaxTemp: Double? {
        backingData.days.map(\.maxTemperature).max()?.value
    }
    var range: Double? {
        guard let minimimMinTemp, let maximumMaxTemp else {
            return nil
        }
        return maximumMaxTemp - minimimMinTemp
    }

    let formatter: MeasurementFormatter
    let backingData: Forecast

    init(forecast: Forecast, formatter: MeasurementFormatter) {
        self.backingData = forecast
        self.formatter = formatter
        self.days = forecast.days.map { FormattedForecastDay(forecastDay: $0, formatter: formatter) }
    }
}

struct FormattedForecastDay: Hashable {
    var date: String {
        backingData.date.formatted()
    }
    var maxTemperature: String {
        formatter.string(from: backingData.maxTemperature)
    }
    var minTemperature: String {
        formatter.string(from: backingData.minTemperature)
    }
    var temperatureRange: Double {
        (backingData.maxTemperature - backingData.minTemperature).value
    }
    var averageTemperature: String {
        formatter.string(from: backingData.averageTemperature)
    }
    var maxWind: String {
        formatter.string(from: backingData.maxWind)
    }
    var totalPrecipitation: String {
        formatter.string(from: backingData.totalPrecipitation)
    }
    var totalSnow: String {
        formatter.string(from: backingData.totalSnow)
    }
    var averageVisibility: String {
        formatter.string(from: backingData.averageVisibility)
    }
    var averageHumidity: String {
        "\(backingData.averageHumidity)%"
    }
    var dailyWillItRain: Bool {
        backingData.dailyWillItRain
    }
    var dailyChanceOfRain: String {
        "\(backingData.dailyChanceOfRain)%"
    }
    var dailyWillItSnow: Bool {
        backingData.dailyWillItSnow
    }
    var dailyChanceOfSnow: String {
        "\(backingData.dailyChanceOfSnow)%"
    }
    var condition: WeatherCondition {
        backingData.condition
    }
    var uv: String {
        String(backingData.uv)
    }
//    let hours: [Hour]

    let formatter: MeasurementFormatter
    let backingData: ForecastDay

    init(forecastDay: ForecastDay, formatter: MeasurementFormatter) {
        self.backingData = forecastDay
        self.formatter = formatter
    }
}
