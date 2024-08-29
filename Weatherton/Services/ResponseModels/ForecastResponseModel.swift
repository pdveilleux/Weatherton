//
//  ForecastResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

struct ForecastResponseModel: Codable {
    let location: LocationResponseModel
    let current: CurrentResponseModel
    let forecast: ForecastItem
}

extension ForecastResponseModel {
    struct ForecastItem: Codable {
        let forecastday: [ForecastDayResponseModel]
    }
}

extension ForecastResponseModel.ForecastItem {
    func convertToForecastDays() -> [ForecastDay] {
        forecastday.map { $0.convertToForecastDay() }
    }
}

extension ForecastResponseModel {
    func convertToForecast() -> Forecast {
        Forecast(
            location: location.convertToLocation(),
            days: forecast.convertToForecastDays()
        )
    }
}
