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
    /// Daily forecast data.
    let days: [FormattedForecastDay]

    /// The lowest minimum daily temperature in the forecast.
    var minimimMinTemp: Double? {
        backingData.days.map(\.minTemperature).min()?.value
    }
    /// The highest maximum daily temperature in the forecast.
    var maximumMaxTemp: Double? {
        backingData.days.map(\.maxTemperature).max()?.value
    }
    /// The difference between the highest temp and lowest temp in the forecast.
    var temperatureRange: Double? {
        guard let minimimMinTemp, let maximumMaxTemp else {
            return nil
        }
        return maximumMaxTemp - minimimMinTemp
    }
    /// The next 24 hours of hourly forecast data.
    var hourlyForecast: [FormattedForecastDay.Hour] {
        let now = Date.now
        // Prefix 2 days because we know the next 24 hours will be contained within those days.
        let firstTwoDays: [ForecastDay] = Array(backingData.days.prefix(2))
        return firstTwoDays
            .flatMap(\.hours)
            .filter { hour in
                // The time must be between now and 24 hours from now.
                hour.time > now && hour.time < now + 60 * 60 * 24
            }
            .map { FormattedForecastDay.Hour(hour: $0, formatter: formatter) }
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
        backingData.date.formatted(.dateTime.weekday(.abbreviated))
    }
    var dateAccessibilityLabel: String {
        backingData.date.formatted(.dateTime.weekday(.wide))
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
        backingData.averageHumidity.formatted(.percent)
    }
    var dailyWillItRain: Bool {
        backingData.dailyWillItRain
    }
    var dailyChanceOfRain: String {
        backingData.dailyChanceOfRain.formatted(.percent)
    }
    var dailyWillItSnow: Bool {
        backingData.dailyWillItSnow
    }
    var dailyChanceOfSnow: String {
        backingData.dailyChanceOfSnow.formatted(.percent)
    }
    var description: String {
        backingData.description
    }
    var systemImage: String? {
        backingData.systemImage
    }
    var uv: String {
        String(backingData.uv)
    }
    var hours: [Hour] {
        backingData.hours.map { Hour(hour: $0, formatter: formatter) }
    }

    let formatter: MeasurementFormatter
    let backingData: ForecastDay

    init(forecastDay: ForecastDay, formatter: MeasurementFormatter) {
        self.backingData = forecastDay
        self.formatter = formatter
    }
}

extension FormattedForecastDay {
    struct Hour: Hashable {
        var time: String {
            backingData.time.formatted(.dateTime.hour())
        }
        var apparentTemperature: String {
            formatter.string(from: backingData.apparentTemperature)
        }
        var dewPoint: String {
            formatter.string(from: backingData.dewPoint)
        }
        var humidity: String {
            backingData.humidity.formatted(.percent)
        }
        var temperature: String {
            formatter.string(from: backingData.temperature)
        }
        var description: String {
            backingData.description
        }
        var systemImage: String? {
            backingData.systemImage
        }

        let formatter: MeasurementFormatter
        let backingData: ForecastDay.Hour

        init(hour: ForecastDay.Hour, formatter: MeasurementFormatter) {
            self.backingData = hour
            self.formatter = formatter
        }
    }
}
