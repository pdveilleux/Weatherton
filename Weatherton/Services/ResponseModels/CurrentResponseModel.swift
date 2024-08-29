//
//  CurrentResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

struct CurrentResponseModel: Codable {
    /// Local time when the real time data was updated in unix time.
    let lastUpdatedEpoch: Int
    /// Local time when the real time data was updated.
    let lastUpdated: String
    /// Temperature in celsius
    let tempC: Double
    /// Temperature in fahrenheit
    let tempF: Double
    /// Whether to show day condition icon or night icon
    ///
    /// 1 = Yes, 0 = No
    let isDay: Int
    /// Contextual information about the current weather.
    let condition: ConditionResponseModel
    /// Wind speed in miles per hour
    let windMph: Double
    /// Wind speed in kilometers per hour
    let windKph: Double
    /// Wind direction in degrees
    let windDegree: Int
    /// Wind direction as 16 point compass. e.g.: NSW
    let windDir: String
    /// Pressure in millibars
    let pressureMb: Double
    /// Pressure in inches
    let pressureIn: Double
    /// Precipitation amount in millimeters
    let precipMm: Double
    /// Precipitation amount in inches
    let precipIn: Double
    /// Humidity as a percentage
    let humidity: Int
    /// Cloud cover as a percentage
    let cloud: Int
    /// Feels like temperature in celcius
    let feelslikeC: Double
    /// Feels like temperature in fahrenheit
    let feelslikeF: Double
    /// Windchill temperature in celcius
    let windchillC: Double
    /// Windchill temperature in fahrenheit
    let windchillF: Double
    /// Heat index in celcius
    let heatindexC: Double
    /// Heat index in fahrenheit
    let heatindexF: Double
    /// Dew point in celcius
    let dewpointC: Double
    /// Dew point in fahrenheit
    let dewpointF: Double
    /// Visibility in kilometers
    let visKm: Double
    /// Visibility in miles
    let visMiles: Double
    /// UV index
    let uv: Double
    /// Wind gust in miles per hour
    let gustMph: Double
    /// Wind gust in kilometers per hour
    let gustKph: Double
    /// Air quality data
//        let airQuality: AirQuality
}

extension CurrentResponseModel {
    struct AirQuality: Codable {
        /// Carbon Monoxide (μg/m3)
        let co: Double
        /// Nitrogen dioxide (μg/m3)
        let no2: Double
        /// Ozone (μg/m3)
        let o3: Double
        /// Sulphur dioxide (μg/m3)
        let so2: Double
        /// PM2.5 (μg/m3)
        let pm25: Double
        /// PM10 (μg/m3)
        let pm10: Double
        /// US - EPA standard.
        ///
        /// - 1: Good
        /// - 2: Moderate
        /// - 3: Unhealthy for sensitive group
        /// - 4: Unhealthy
        /// - 5: Very Unhealthy
        /// - 6: Hazardous
        let usEpaIndex: Int
        /// UK Defra Index
        let gbDefraIndex: Int
    }
}
