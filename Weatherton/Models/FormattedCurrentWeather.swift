//
//  FormattedCurrentWeather.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/26/24.
//

import Foundation

struct FormattedCurrentWeather: Hashable {
    var apparentTemperature: String {
        formatter.string(from: backingData.apparentTemperature)
    }
    var dewPoint: String {
        formatter.string(from: backingData.dewPoint)
    }
    var humidity: String {
        String("\(backingData.humidity)%")
    }
    var temperature: String {
        formatter.string(from: backingData.temperature)
    }
    var condition: WeatherCondition {
        backingData.condition
    }
    var location: Location {
        backingData.location
    }

    let formatter: MeasurementFormatter
    let backingData: CurrentWeather

    init(currentWeather: CurrentWeather, formatter: MeasurementFormatter) {
        self.backingData = currentWeather
        self.formatter = formatter
    }
}
