//
//  ConditionResponseModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/28/24.
//

import Foundation

struct ConditionResponseModel: Codable {
    /// Weather condition description.
    let text: String
    /// Weather icon url which excludes the `http:` or `https:` protocol prefix.
    let icon: String
    /// Unique weather condition code, specific to WeatherAPI.
    let code: Int
}

extension ConditionResponseModel {
    func getSystemImageNameForConditionCode(isDay: Bool) -> String {
        switch (code, isDay) {
        case (1000, true): "sun.max.fill"
        case (1000, false): "moon.fill"
        case (1003, true): "cloud.sun.fill"
        case (1003, false): "cloud.moon.fill"
        case (1006, true): "cloud.fill"
        case (1006, false): "cloud.fill"
        case (1009, true): "cloud.fill"
        case (1009, false): "cloud.fill"
        case (1030, true): "cloud.fog.fill"
        case (1030, false): "cloud.fog.fill"
        case (1063, true): "cloud.sun.rain.fill"
        case (1063, false): "cloud.moon.rain.fill"
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
        case (1150, true): "cloud.drizzle.fill"
        case (1150, false): "cloud.drizzle.fill"
        case (1153, true): "cloud.drizzle.fill"
        case (1153, false): "cloud.drizzle.fill"
        case (1168, true): "cloud.sleet.fill"
        case (1168, false): "cloud.sleet.fill"
        case (1171, true): "cloud.sleet.fill"
        case (1171, false): "cloud.sleet.fill"
        case (1180, true): "cloud.sun.rain.fill"
        case (1180, false): "cloud.moon.rain.fill"
        case (1183, true): "cloud.drizzle.fill"
        case (1183, false): "cloud.drizzle.fill"
        case (1186, true): "cloud.rain.fill"
        case (1186, false): "cloud.rain.fill"
        case (1189, true): "cloud.rain.fill"
        case (1189, false): "cloud.rain.fill"
        case (1192, true): "cloud.heavyrain.fill"
        case (1192, false): "cloud.heavyrain.fill"
        case (1195, true): "cloud.heavyrain.fill"
        case (1195, false): "cloud.heavyrain.fill"
        case (1198, true): "cloud.sleet.fill"
        case (1198, false): "cloud.sleet.fill"
        case (1201, true): "cloud.sleet.fill"
        case (1201, false): "cloud.sleet.fill"
        case (1204, true): "cloud.sleet.fill"
        case (1204, false): "cloud.sleet.fill"
        case (1207, true): "cloud.sleet.fill"
        case (1207, false): "cloud.sleet.fill"
        case (1210, true): "sun.snow.fill"
        case (1210, false): "sun.snow.fill"
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
        case (1237, true): "cloud.hail.fill"
        case (1237, false): "cloud.hail.fill"
        case (1240, true): "cloud.drizzle.fill"
        case (1240, false): "cloud.drizzle.fill"
        case (1243, true): "cloud.rain.fill"
        case (1243, false): "cloud.rain.fill"
        case (1246, true): "cloud.heavyrain.fill"
        case (1246, false): "cloud.heavyrain.fill"
        case (1249, true): "cloud.sleet.fill"
        case (1249, false): "cloud.sleet.fill"
        case (1252, true): "cloud.sleet.fill"
        case (1252, false): "cloud.sleet.fill"
        case (1255, true): "cloud.snow.fill"
        case (1255, false): "cloud.snow.fill"
        case (1258, true): "cloud.snow.fill"
        case (1258, false): "cloud.snow.fill"
        case (1261, true): "cloud.sleet.fill"
        case (1261, false): "cloud.sleet.fill"
        case (1264, true): "cloud.sleet.fill"
        case (1264, false): "cloud.sleet.fill"
        case (1273, true): "cloud.sun.bolt.fill"
        case (1273, false): "cloud.moon.bolt.fill"
        case (1276, true): "cloud.bolt.rain.fill"
        case (1276, false): "cloud.bolt.rain.fill"
        case (1279, true): "cloud.snow.fill"
        case (1279, false): "cloud.snow.fill"
        case (1282, true): "cloud.snow.fill"
        case (1282, false): "cloud.snow.fill"
        default: ""
        }
    }
}
