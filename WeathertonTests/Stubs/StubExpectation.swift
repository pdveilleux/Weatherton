//
//  StubExpectation.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/30/24.
//

import Foundation
@testable import Weatherton

enum StubExpectation {}

extension StubExpectation {
    static var uuidFactory: UUIDFactory?
}

extension StubExpectation {
    static var currentWeather: CurrentWeather {
        guard let uuid = uuidFactory?.uuid() else {
            fatalError("UUIDFactory must return non-nil UUID.")
        }
        return CurrentWeather(
            id: uuid,
            apparentTemperature: Measurement(value: 15.1, unit: .celsius),
            dewPoint: Measurement(value: 10.6, unit: .celsius),
            humidity: 77,
            temperature: Measurement(value: 15.1, unit: .celsius),
            visibility: Measurement(value: 10.0, unit: .kilometers),
            windSpeed: Measurement(value: 15.1, unit: .kilometersPerHour),
            windDirection: "NE",
            updatedDate: Date(timeIntervalSince1970: 1725067800),
            description: "Partly cloudy",
            systemImage: "cloud.moon.fill",
            location: PreviewData.Location.london
        )
    }

    static var forecast: Forecast {
        Forecast(
            location: PreviewData.Location.minneapolis,
            days: [
                ForecastDay(
                    date: Date(timeIntervalSince1970: 1724976000),
                    maxTemperature: Measurement(value: 24.8, unit: .celsius),
                    minTemperature: Measurement(value: 15, unit: .celsius),
                    averageTemperature: Measurement(value: 20.2, unit: .celsius),
                    maxWind: Measurement(value: 17.6, unit: .kilometersPerHour),
                    totalPrecipitation: Measurement(value: 0.02, unit: .millimeters),
                    totalSnow: Measurement(value: 0, unit: .centimeters),
                    averageVisibility: Measurement(value: 9.3, unit: .kilometers),
                    averageHumidity: 63,
                    dailyWillItRain: false,
                    dailyChanceOfRain: 0,
                    dailyWillItSnow: false,
                    dailyChanceOfSnow: 0,
                    description: "Sunny",
                    systemImage: "sun.max.fill",
                    uv: 6,
                    hours: [
                        ForecastDay.Hour(
                            time: Date(timeIntervalSince1970: 1724994000),
                            apparentTemperature: Measurement(value: 19.7, unit: .celsius),
                            dewPoint: Measurement(value: 19, unit: .celsius),
                            humidity: 95,
                            temperature: Measurement(value: 19.6, unit: .celsius),
                            description: "Mist",
                            systemImage: "cloud.fog.fill"
                        ),
                        ForecastDay.Hour(
                            time: Date(timeIntervalSince1970: 1724997600),
                            apparentTemperature: Measurement(value: 19.2, unit: .celsius),
                            dewPoint: Measurement(value: 18.7, unit: .celsius),
                            humidity: 95,
                            temperature: Measurement(value: 19.2, unit: .celsius),
                            description: "Mist",
                            systemImage: "cloud.fog.fill"
                        ),
                        ForecastDay.Hour(
                            time: Date(timeIntervalSince1970: 1725001200),
                            apparentTemperature: Measurement(value: 18.1, unit: .celsius),
                            dewPoint: Measurement(value: 17, unit: .celsius),
                            humidity: 89,
                            temperature: Measurement(value: 18.1, unit: .celsius),
                            description: "Clear",
                            systemImage: "moon.fill"
                        )
                    ]
                )
            ]
        )
    }

    static var searchLocations: [Location] {
        [
            Location(
                name: "London",
                region: "City of London, Greater London",
                country: "United Kingdom",
                latitude: 51.52,
                longitude: -0.11
            ),
            Location(
                name: "London",
                region: "Ontario",
                country: "Canada",
                latitude: 42.98,
                longitude: -81.25
            ),
            Location(
                name: "Londonderry",
                region: "New Hampshire",
                country: "United States of America",
                latitude: 42.87,
                longitude: -71.37
            )
        ]
    }
}
