//
//  CurrentWeatherResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

struct CurrentWeatherResponseModel: Codable {
    let location: Location
    let current: Current
}

extension CurrentWeatherResponseModel {
    struct Location: Codable {
        /// The location name, typically a city.
        let name: String
        /// The greater region of the location.
        let region: String
        /// The location's country.
        let country: String
        /// The location's latitude.
        let lat: Double
        /// The location's longitude.
        let lon: Double
    }

    struct Current: Codable {
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
        let condition: Condition
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
}

extension CurrentWeatherResponseModel.Current {
    struct Condition: Codable {
        /// Weather condition description.
        let text: String
        /// Weather icon url which excludes the `http:` or `https:` protocol prefix.
        let icon: String
        /// Unique weather condition code, specific to WeatherAPI.
        let code: Int
    }

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

extension CurrentWeatherResponseModel {
    func convertToCurrentWeather() -> CurrentWeather {
        CurrentWeather(
            apparentTemperature: Measurement(value: current.feelslikeC, unit: .celsius),
            dewPoint: Measurement(value: current.dewpointC, unit: .celsius),
            humidity: current.humidity,
            temperature: Measurement(value: current.tempC, unit: .celsius),
            updatedDate: Date(timeIntervalSince1970: Double(current.lastUpdatedEpoch)),
            condition: WeatherCondition(
                description: current.condition.text,
                systemImage: getSystemImageNameForConditionCode(current.condition.code, isDay: current.isDay == 1)
            ),
            location: Weatherton.Location(
                name: location.name,
                region: location.region,
                country: location.country,
                latitude: location.lat,
                longitude: location.lon
            )
        )
    }

    private func getSystemImageNameForConditionCode(_ code: Int, isDay: Bool) -> String {
        switch (code, isDay) {
        case (1000, true): "sun.max.fill"
        case (1000, false): "moon.fill"
        case (1003, true): "cloud.sun.fill"
        case (1003, false): "cloud.moon.fill"
        case (1006, true): "cloud.fill"
        case (1006, false): "cloud.fill"
        case (1009, true): "cloud.fill"
        case (1009, false): "cloud.fill"
        case (1030, true): "cloud.fog"
        case (1030, false): "cloud.fog"
        case (1063, true): "cloud.sun.rain"
        case (1063, false): "cloud.moon.rain"
        case (1066, true): "sun.snow.fill"
        case (1066, false): "cloud.snow.fill"
        case (1069, true): "cloud.sleet.fill"
        case (1069, false): "cloud.sleet.fill"
        case (1072, true): "cloud.sleet.fill"
        case (1072, false): "cloud.sleet.fill"
        case (1087, true): "cloud.sun.bolt.fill"
        case (1087, false): "cloud.moon.bolt.fill"
        case (1087, true): "wind.snow"
        case (1087, false): "wind.snow"
        case (1114, true): "wind.snow"
        case (1114, false): "wind.snow"
        case (1135, true): "cloud.fog.fill"
        case (1135, false): "cloud.fog.fill"
        case (1147, true): "cloud.fog.fill"
        case (1147, false): "cloud.fog.fill"
        case (1150, true): "cloud.drizzle"
        case (1150, false): "cloud.drizzle"
        case (1153, true): "cloud.drizzle.fill"
        case (1153, false): "cloud.drizzle.fill"
        case (1168, true): "cloud.sleet"
        case (1168, false): "cloud.sleet"
        case (1171, true): "cloud.sleet.fill"
        case (1171, false): "cloud.sleet.fill"
        case (1180, true): "cloud.sun.rain"
        case (1180, false): "cloud.moon.rain"
        case (1183, true): "cloud.drizzle.fill"
        case (1183, false): "cloud.drizzle.fill"
        case (1186, true): "cloud.rain"
        case (1186, false): "cloud.rain"
        case (1189, true): "cloud.rain.fill"
        case (1189, false): "cloud.rain.fill"
        case (1192, true): "cloud.heavyrain"
        case (1192, false): "cloud.heavyrain"
        case (1195, true): "cloud.heavyrain.fill"
        case (1195, false): "cloud.heavyrain.fill"
        case (1198, true): "cloud.sleet"
        case (1198, false): "cloud.sleet"
        case (1201, true): "cloud.sleet.fill"
        case (1201, false): "cloud.sleet.fill"
        case (1204, true): "cloud.sleet"
        case (1204, false): "cloud.sleet"
        case (1207, true): "cloud.sleet.fill"
        case (1207, false): "cloud.sleet.fill"
        case (1210, true): "sun.snow"
        case (1210, false): "sun.snow"
        case (1213, true): "snowflake"
        case (1213, false): "snowflake"
        case (1216, true): "snowflake"
        case (1216, false): "snowflake"
        case (1219, true): "snowflake"
        case (1219, false): "snowflake"
        case (1222, true): "snowflake"
        case (1222, false): "snowflake"
        case (1225, true): "snowflake"
        case (1225, false): "snowflake"
        case (1237, true): "cloud.hail"
        case (1237, false): "cloud.hail"
        case (1240, true): "cloud.drizzle"
        case (1240, false): "cloud.drizzle"
        case (1243, true): "cloud.rain.fill"
        case (1243, false): "cloud.rain.fill"
        case (1246, true): "cloud.heavyrain.fill"
        case (1246, false): "cloud.heavyrain.fill"
        case (1249, true): "cloud.sleet"
        case (1249, false): "cloud.sleet"
        case (1252, true): "cloud.sleet.fill"
        case (1252, false): "cloud.sleet.fill"
        case (1255, true): "cloud.snow"
        case (1255, false): "cloud.snow"
        case (1258, true): "cloud.snow.fill"
        case (1258, false): "cloud.snow.fill"
        case (1261, true): "cloud.sleet"
        case (1261, false): "cloud.sleet"
        case (1264, true): "cloud.sleet.fill"
        case (1264, false): "cloud.sleet.fill"
        case (1273, true): "cloud.sun.bolt"
        case (1273, false): "cloud.moon.bolt"
        case (1276, true): "cloud.bolt.rain.fill"
        case (1276, false): "cloud.bolt.rain.fill"
        case (1279, true): "cloud.snow"
        case (1279, false): "cloud.snow"
        case (1282, true): "cloud.snow.fill"
        case (1282, false): "cloud.snow.fill"
        default: ""
        }
    }
}
