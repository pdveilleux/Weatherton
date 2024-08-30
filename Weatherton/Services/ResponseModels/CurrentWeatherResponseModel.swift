//
//  CurrentWeatherResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

struct CurrentWeatherResponseModel: Codable {
    let location: LocationResponseModel
    let current: CurrentResponseModel
}

extension CurrentWeatherResponseModel {
    func convertToCurrentWeather() -> CurrentWeather {
        CurrentWeather(
            id: UUID(),
            apparentTemperature: Measurement(value: current.feelslikeC, unit: .celsius),
            dewPoint: Measurement(value: current.dewpointC, unit: .celsius),
            humidity: current.humidity,
            temperature: Measurement(value: current.tempC, unit: .celsius), 
            visibility: Measurement(value: current.visKm, unit: .kilometers),
            windSpeed: Measurement(value: current.windKph, unit: .kilometersPerHour),
            windDirection: current.windDir,
            updatedDate: Date(timeIntervalSince1970: Double(current.lastUpdatedEpoch)),
            condition: current.condition.convertToWeatherCondition(isDay: current.isDay == 1),
            location: location.convertToLocation()
        )
    }
}
