//
//  Strings.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 9/1/24.
//

import Foundation

enum Strings {
    static let currentWeatherHeader = String(localized: "Current Weather")
    static let locations = String(localized: "Locations")
    static let hourlyForecast = String(localized: "24 Hour Forecast")
    static let dailyForecast = String(localized: "Daily Forecast")
    static let humidity = String(localized: "Humidity")
    static let visibility = String(localized: "Visibility")
    static let wind = String(localized: "Wind")
    static let notConnectedToInternet = String(localized: "Offline")

    static func hourForecastAccessibilityLabel(time: String, temperature: String, description: String) -> String {
        String(localized: "\(time), \(temperature), \(description)", comment: "The accessibility label for a single hour forecast in the next 24 hours.")
    }

    static func dayForecastAccessibilityLabel(date: String, description: String, low: String, high: String) -> String {
        String(localized: "\(date), \(description), Low \(low), High \(high)", comment: "The accessibility label for a single day forecast in the week forecast.")
    }

    static func locationAccessibilityLabel(location: String, temperature: String, description: String) -> String {
        String(localized: "\(location), \(temperature), \(description)", comment: "The accessibility label for the current weather of a location.")
    }

    static func locationName(name: String, region: String) -> String {
        String(localized: "\(name), \(region)", comment: "The city and region formatting for a location name.")
    }
}
