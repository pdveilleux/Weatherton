//
//  ForecastDayResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

struct ForecastDayResponseModel: Codable {
    let date: String
    let dateEpoch: Int
    let day: DayResponseModel
    let hour: [HourResponseModel]
}

extension ForecastDayResponseModel {
    struct DayResponseModel: Codable {
        let maxtempC: Double
        let mintempC: Double
        let avgtempC: Double
        let maxwindKph: Double
        let totalprecipMm: Double
        let totalsnowCm: Double
        let avgvisKm: Double
        let avghumidity: Int
        let dailyWillItRain: Int
        let dailyChanceOfRain: Int
        let dailyWillItSnow: Int
        let dailyChanceOfSnow: Int
        let condition: ConditionResponseModel
        let uv: Double
    }

    struct HourResponseModel: Codable {
        /// Local time when the real time data was updated in unix time.
        let timeEpoch: Int
        /// Local time when the real time data was updated.
        let time: String
        /// Temperature in celsius
        let tempC: Double
        /// Whether to show day condition icon or night icon
        ///
        /// 1 = Yes, 0 = No
        let isDay: Int
        /// Contextual information about the current weather.
        let condition: ConditionResponseModel
        /// Wind speed in kilometers per hour
        let windKph: Double
        /// Wind direction in degrees
        let windDegree: Int
        /// Wind direction as 16 point compass. e.g.: NSW
        let windDir: String
        /// Pressure in millibars
        let pressureMb: Double
        /// Precipitation amount in millimeters
        let precipMm: Double
        /// Snow amount in centimeters
        let snowCm: Double
        /// Humidity as a percentage
        let humidity: Int
        /// Cloud cover as a percentage
        let cloud: Int
        /// Feels like temperature in celcius
        let feelslikeC: Double
        /// Windchill temperature in celcius
        let windchillC: Double
        /// Heat index in celcius
        let heatindexC: Double
        /// Dew point in celcius
        let dewpointC: Double
        /// Visibility in kilometers
        let visKm: Double
        /// UV index
        let uv: Double
        /// Wind gust in kilometers per hour
        let gustKph: Double
    }
}

extension ForecastDayResponseModel {
    func convertToForecastDay() -> ForecastDay {
        ForecastDay(
            date: Date(timeIntervalSince1970: Double(dateEpoch)),
            maxTemperature: Measurement(value: day.maxtempC, unit: .celsius),
            minTemperature: Measurement(value: day.mintempC, unit: .celsius),
            averageTemperature: Measurement(value: day.avgtempC, unit: .celsius),
            maxWind: Measurement(value: day.maxwindKph, unit: .kilometersPerHour),
            totalPrecipitation: Measurement(value: day.totalprecipMm, unit: .millimeters),
            totalSnow: Measurement(value: day.totalsnowCm, unit: .centimeters),
            averageVisibility: Measurement(value: day.avgvisKm, unit: .kilometers),
            averageHumidity: day.avghumidity,
            dailyWillItRain: day.dailyWillItRain == 1,
            dailyChanceOfRain: day.dailyChanceOfRain,
            dailyWillItSnow: day.dailyWillItSnow == 1,
            dailyChanceOfSnow: day.dailyChanceOfSnow,
            condition: day.condition.convertToWeatherCondition(isDay: true),
            uv: day.uv,
            hours: hour.map { $0.convertToHour() }
        )
    }
}

extension ForecastDayResponseModel.HourResponseModel {
    func convertToHour() -> ForecastDay.Hour {
        ForecastDay.Hour(
            time: Date(timeIntervalSince1970: Double(timeEpoch)),
            apparentTemperature: Measurement(value: feelslikeC, unit: .celsius),
            dewPoint: Measurement(value: dewpointC, unit: .celsius),
            humidity: humidity,
            temperature: Measurement(value: tempC, unit: .celsius),
            condition: condition.convertToWeatherCondition(isDay: isDay == 1)
        )
    }
}
