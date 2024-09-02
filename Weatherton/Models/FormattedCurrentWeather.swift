//
//  FormattedCurrentWeather.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/26/24.
//

import Foundation
import SwiftUI

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
    var visibility: String {
        formatter.string(from: backingData.visibility)
    }
    var windSpeed: String {
        formatter.string(from: backingData.windSpeed)
    }
    var windDirection: String {
        backingData.windDirection
    }
    var windSpeedAndDirection: String {
        windSpeed + " " + windDirection
    }
    var windSpeedAndDirectionAccessibilityLabel: String {
        windSpeed + " " + windDirectionDescription
    }
    var description: String {
        backingData.description
    }
    var systemImage: String? {
        backingData.systemImage
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

extension FormattedCurrentWeather {
    var temperatureGradient: Gradient {
        let temp = backingData.apparentTemperature.converted(to: .celsius).value
        return switch temp {
        case 30...:
            Gradient(colors: [.red, .orange])
        case 20...:
            Gradient(colors: [.orange, .green])
        case 10...:
            Gradient(colors: [.green, .blue])
        case 0...:
            Gradient(colors: [.blue, .indigo])
        case ...0:
            Gradient(colors: [.blue, .init(white: 0.7)])
        default:
            Gradient(colors: [.blue, .teal])
        }
    }

    var windDirectionDescription: String {
        switch windDirection {
        case "N": "North"
        case "NNE": "North North East"
        case "NE": "North East"
        case "ENE": "East North East"
        case "E": "East"
        case "ESE": "East South East"
        case "SE": "South East"
        case "SSE": "South South East"
        case "S": "South"
        case "SSW": "South South West"
        case "SW": "South West"
        case "WSW": "West South West"
        case "W": "West"
        case "WNW": "West North West"
        case "NW": "North West"
        case "NNW": "North North West"
        default: ""
        }
    }
}
