//
//  TemperatureBarTests.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/31/24.
//

import XCTest
@testable import Weatherton

final class TemperatureBarTests: XCTestCase {
    func testGetWidth() {
        // Given
        // - Two days in forecast
        // - Temperature spread of 20 degrees
        // - The day has a 6 degree spread
        // - The width of the bar is 100
        let day1 = ForecastDay(
            date: .now,
            maxTemperature: Measurement(value: 40, unit: .celsius),
            minTemperature: Measurement(value: 20, unit: .celsius),
            averageTemperature: Measurement(value: 0, unit: .celsius),
            maxWind: Measurement(value: 0, unit: .kilometersPerHour),
            totalPrecipitation: Measurement(value: 0, unit: .millimeters),
            totalSnow: Measurement(value: 0, unit: .centimeters),
            averageVisibility: Measurement(value: 0, unit: .kilometers),
            averageHumidity: 0,
            dailyWillItRain: false,
            dailyChanceOfRain: 0,
            dailyWillItSnow: false,
            dailyChanceOfSnow: 0,
            description: "",
            systemImage: "",
            uvIndex: 0,
            hours: []
        )
        let day2 = ForecastDay(
            date: .now,
            maxTemperature: Measurement(value: 33, unit: .celsius),
            minTemperature: Measurement(value: 27, unit: .celsius),
            averageTemperature: Measurement(value: 0, unit: .celsius),
            maxWind: Measurement(value: 0, unit: .kilometersPerHour),
            totalPrecipitation: Measurement(value: 0, unit: .millimeters),
            totalSnow: Measurement(value: 0, unit: .centimeters),
            averageVisibility: Measurement(value: 0, unit: .kilometers),
            averageHumidity: 0,
            dailyWillItRain: false,
            dailyChanceOfRain: 0,
            dailyWillItSnow: false,
            dailyChanceOfSnow: 0,
            description: "",
            systemImage: "",
            uvIndex: 0,
            hours: []
        )
        let formattedForecast = FormattedForecast(
            forecast: Forecast(
                location: PreviewData.Location.minneapolis,
                days: [day1, day2]
            ),
            formatter: PreviewData.Formatter.temperature
        )
        let formattedDay = FormattedForecastDay(
            forecastDay: day2,
            formatter: PreviewData.Formatter.temperature
        )
        let temperatureBar = TemperatureBar(
            forecast: formattedForecast,
            day: formattedDay
        )
        let width: Double = 100

        // When
        // - Get width of temperature bar for a given day in the forecast
        let result = temperatureBar.getWidth(
            forecast: formattedForecast,
            day: formattedDay,
            width: width
        )

        // Then
        // - Expect result of 30
        XCTAssertEqual(result, CGFloat(30))
    }

    func testGetOffset() {
        // Given
        // - Two days in forecast
        // - Temperature spread of 20 degrees
        // - The day has a 5 degree spread, 5 degrees above the forecast minimum
        // - The width of the bar is 100
        let day1 = ForecastDay(
            date: .now,
            maxTemperature: Measurement(value: 40, unit: .celsius),
            minTemperature: Measurement(value: 20, unit: .celsius),
            averageTemperature: Measurement(value: 0, unit: .celsius),
            maxWind: Measurement(value: 0, unit: .kilometersPerHour),
            totalPrecipitation: Measurement(value: 0, unit: .millimeters),
            totalSnow: Measurement(value: 0, unit: .centimeters),
            averageVisibility: Measurement(value: 0, unit: .kilometers),
            averageHumidity: 0,
            dailyWillItRain: false,
            dailyChanceOfRain: 0,
            dailyWillItSnow: false,
            dailyChanceOfSnow: 0,
            description: "",
            systemImage: "",
            uvIndex: 0,
            hours: []
        )
        let day2 = ForecastDay(
            date: .now,
            maxTemperature: Measurement(value: 25, unit: .celsius),
            minTemperature: Measurement(value: 30, unit: .celsius),
            averageTemperature: Measurement(value: 0, unit: .celsius),
            maxWind: Measurement(value: 0, unit: .kilometersPerHour),
            totalPrecipitation: Measurement(value: 0, unit: .millimeters),
            totalSnow: Measurement(value: 0, unit: .centimeters),
            averageVisibility: Measurement(value: 0, unit: .kilometers),
            averageHumidity: 0,
            dailyWillItRain: false,
            dailyChanceOfRain: 0,
            dailyWillItSnow: false,
            dailyChanceOfSnow: 0,
            description: "",
            systemImage: "",
            uvIndex: 0,
            hours: []
        )
        let formattedForecast = FormattedForecast(
            forecast: Forecast(
                location: PreviewData.Location.minneapolis,
                days: [day1, day2]
            ),
            formatter: PreviewData.Formatter.temperature
        )
        let formattedDay = FormattedForecastDay(
            forecastDay: day2,
            formatter: PreviewData.Formatter.temperature
        )
        let temperatureBar = TemperatureBar(
            forecast: formattedForecast,
            day: formattedDay
        )
        let width: Double = 100

        // When
        // - Get width of temperature bar for a given day in the forecast
        let result = temperatureBar.getOffset(
            forecast: formattedForecast,
            day: formattedDay,
            width: width
        )

        // Then
        // - Expect result of 30
        XCTAssertEqual(result, CGFloat(-12.5))
    }
}
