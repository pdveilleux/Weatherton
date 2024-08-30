//
//  CurrentWeatherPersistenceModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/25/24.
//

import Foundation
import SwiftData

@Model
final class CurrentWeatherPersistenceModel {
    let id: UUID
    let apparentTemperatureC: Double
    let dewPointC: Double
    let humidity: Int
    let temperatureC: Double
    let visibilityKm: Double
    let windSpeedKm: Double
    let windDirection: String
    let conditionDescription: String
    let systemImage: String?
    let updatedDate: Date
    @Relationship(inverse: \LocationPersistenceModel.weather) var location: LocationPersistenceModel?
    
    init(currentWeather: CurrentWeather) {
        id = currentWeather.id
        apparentTemperatureC = currentWeather.apparentTemperature.converted(to: .celsius).value
        dewPointC = currentWeather.dewPoint.converted(to: .celsius).value
        humidity = currentWeather.humidity
        temperatureC = currentWeather.temperature.converted(to: .celsius).value
        visibilityKm = currentWeather.visibility.converted(to: .kilometers).value
        windSpeedKm = currentWeather.windSpeed.converted(to: .kilometersPerHour).value
        windDirection = currentWeather.windDirection
        conditionDescription = currentWeather.condition.description
        systemImage = currentWeather.condition.systemImage
        updatedDate = currentWeather.updatedDate
    }
}

extension CurrentWeatherPersistenceModel {
    func convertToCurrentWeather() -> CurrentWeather {
        CurrentWeather(
            id: id,
            apparentTemperature: Measurement(value: apparentTemperatureC, unit: .celsius),
            dewPoint: Measurement(value: dewPointC, unit: .celsius),
            humidity: humidity,
            temperature: Measurement(value: temperatureC, unit: .celsius), 
            visibility: Measurement(value: visibilityKm, unit: .kilometers),
            windSpeed: Measurement(value: windSpeedKm, unit: .kilometersPerHour),
            windDirection: windDirection,
            updatedDate: updatedDate,
            condition: WeatherCondition(
                description: conditionDescription,
                systemImage: systemImage
            ),
            location: Weatherton.Location(
                name: "",
                region: "",
                country: "",
                latitude: 0,
                longitude: 0
            )
        )
    }
}
