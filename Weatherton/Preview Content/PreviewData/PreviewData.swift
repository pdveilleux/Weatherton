//
//  PreviewData.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/26/24.
//

import Foundation

#if DEBUG
enum PreviewData {}

extension PreviewData {
    enum CurrentWeather {
        static var london: Weatherton.CurrentWeather {
            Weatherton.CurrentWeather(
                id: UUID(),
                apparentTemperature: Measurement(value: 24.1, unit: .celsius),
                dewPoint: Measurement(value: 10.7, unit: .celsius),
                humidity: 36,
                temperature: Measurement(value: 28.5, unit: .celsius),
                visibility: Measurement(value: 30, unit: .kilometers),
                windSpeed: Measurement(value: 8, unit: .kilometersPerHour),
                windDirection: "ESE",
                updatedDate: .now - (60 * 10),
                description: "Partly Cloudy",
                systemImage: "cloud.sun.fill",
                location: PreviewData.Location.london
            )
        }
        
        static var minneapolis: Weatherton.CurrentWeather {
            Weatherton.CurrentWeather(
                id: UUID(),
                apparentTemperature: Measurement(value: 18, unit: .celsius),
                dewPoint: Measurement(value: 19.2, unit: .celsius),
                humidity: 70,
                temperature: Measurement(value: 31.0, unit: .celsius),
                visibility: Measurement(value: 30, unit: .kilometers),
                windSpeed: Measurement(value: 8, unit: .kilometersPerHour),
                windDirection: "ESE",
                updatedDate: .now - (60 * 10),
                description: "Partly Cloudy",
                systemImage: "cloud.sun.fill",
                location: PreviewData.Location.minneapolis
            )
        }
    }
    
    enum Forecast {
        static var minneapolis: Weatherton.Forecast {
            Weatherton.Forecast(
                location: PreviewData.Location.minneapolis,
                days: [
                    ForecastDay(
                        date: .now,
                        maxTemperature: Measurement(value: 32.4, unit: .celsius),
                        minTemperature: Measurement(value: 25.3, unit: .celsius),
                        averageTemperature: Measurement(value: 28.6, unit: .celsius),
                        maxWind: Measurement(value: 4.9, unit: .kilometersPerHour),
                        totalPrecipitation: Measurement(value: 3, unit: .millimeters),
                        totalSnow: Measurement(value: 0, unit: .centimeters),
                        averageVisibility: Measurement(value: 46.1, unit: .kilometers),
                        averageHumidity: 54,
                        dailyWillItRain: true,
                        dailyChanceOfRain: 54,
                        dailyWillItSnow: false,
                        dailyChanceOfSnow: 0,
                        description: "Partly Cloudy",
                        systemImage: "cloud.sun.fill",
                        uv: 4,
                        hours: (0...23).map { PreviewData.Forecast.Hour.sunny(hour: $0) }
                    ),
                    ForecastDay(
                        date: .now + (60 * 60 * Double(1)),
                        maxTemperature: Measurement(value: 30, unit: .celsius),
                        minTemperature: Measurement(value: 25.3, unit: .celsius),
                        averageTemperature: Measurement(value: 28.6, unit: .celsius),
                        maxWind: Measurement(value: 4.9, unit: .kilometersPerHour),
                        totalPrecipitation: Measurement(value: 3, unit: .millimeters),
                        totalSnow: Measurement(value: 0, unit: .centimeters),
                        averageVisibility: Measurement(value: 46.1, unit: .kilometers),
                        averageHumidity: 54,
                        dailyWillItRain: true,
                        dailyChanceOfRain: 54,
                        dailyWillItSnow: false,
                        dailyChanceOfSnow: 0,
                        description: "Sunny",
                        systemImage: "sun.fill",
                        uv: 4,
                        hours: (0...23).map { PreviewData.Forecast.Hour.sunny(hour: $0, addingDays: 1) }
                    ),
                    ForecastDay(
                        date: .now + (60 * 60 * Double(2)),
                        maxTemperature: Measurement(value: 28, unit: .celsius),
                        minTemperature: Measurement(value: 25.3, unit: .celsius),
                        averageTemperature: Measurement(value: 28.6, unit: .celsius),
                        maxWind: Measurement(value: 4.9, unit: .kilometersPerHour),
                        totalPrecipitation: Measurement(value: 3, unit: .millimeters),
                        totalSnow: Measurement(value: 0, unit: .centimeters),
                        averageVisibility: Measurement(value: 46.1, unit: .kilometers),
                        averageHumidity: 54,
                        dailyWillItRain: true,
                        dailyChanceOfRain: 54,
                        dailyWillItSnow: false,
                        dailyChanceOfSnow: 0,
                        description: "Partly Cloudy",
                        systemImage: "cloud.sun.fill",
                        uv: 4,
                        hours: (0...23).map { PreviewData.Forecast.Hour.sunny(hour: $0, addingDays: 2) }
                    ),
                    ForecastDay(
                        date: .now + (60 * 60 * Double(3)),
                        maxTemperature: Measurement(value: 29, unit: .celsius),
                        minTemperature: Measurement(value: 25.3, unit: .celsius),
                        averageTemperature: Measurement(value: 28.6, unit: .celsius),
                        maxWind: Measurement(value: 4.9, unit: .kilometersPerHour),
                        totalPrecipitation: Measurement(value: 3, unit: .millimeters),
                        totalSnow: Measurement(value: 0, unit: .centimeters),
                        averageVisibility: Measurement(value: 46.1, unit: .kilometers),
                        averageHumidity: 54,
                        dailyWillItRain: true,
                        dailyChanceOfRain: 54,
                        dailyWillItSnow: false,
                        dailyChanceOfSnow: 0,
                        description: "Partly Cloudy",
                        systemImage: "cloud.sun.fill",
                        uv: 4,
                        hours: (0...23).map { PreviewData.Forecast.Hour.sunny(hour: $0, addingDays: 3) }
                    ),
                    ForecastDay(
                        date: .now + (60 * 60 * Double(4)),
                        maxTemperature: Measurement(value: 29, unit: .celsius),
                        minTemperature: Measurement(value: 25.3, unit: .celsius),
                        averageTemperature: Measurement(value: 28.6, unit: .celsius),
                        maxWind: Measurement(value: 4.9, unit: .kilometersPerHour),
                        totalPrecipitation: Measurement(value: 3, unit: .millimeters),
                        totalSnow: Measurement(value: 0, unit: .centimeters),
                        averageVisibility: Measurement(value: 46.1, unit: .kilometers),
                        averageHumidity: 54,
                        dailyWillItRain: true,
                        dailyChanceOfRain: 54,
                        dailyWillItSnow: false,
                        dailyChanceOfSnow: 0,
                        description: "Partly Cloudy",
                        systemImage: "cloud.sun.fill",
                        uv: 4,
                        hours: (0...23).map { PreviewData.Forecast.Hour.sunny(hour: $0, addingDays: 4) }
                    ),
                    ForecastDay(
                        date: .now + (60 * 60 * Double(5)),
                        maxTemperature: Measurement(value: 25, unit: .celsius),
                        minTemperature: Measurement(value: 25.3, unit: .celsius),
                        averageTemperature: Measurement(value: 28.6, unit: .celsius),
                        maxWind: Measurement(value: 4.9, unit: .kilometersPerHour),
                        totalPrecipitation: Measurement(value: 3, unit: .millimeters),
                        totalSnow: Measurement(value: 0, unit: .centimeters),
                        averageVisibility: Measurement(value: 46.1, unit: .kilometers),
                        averageHumidity: 54,
                        dailyWillItRain: true,
                        dailyChanceOfRain: 54,
                        dailyWillItSnow: false,
                        dailyChanceOfSnow: 0,
                        description: "Partly Cloudy",
                        systemImage: "cloud.sun.fill",
                        uv: 4,
                        hours: (0...23).map { PreviewData.Forecast.Hour.sunny(hour: $0, addingDays: 5) }
                    ),
                    ForecastDay(
                        date: .now + (60 * 60 * Double(6)),
                        maxTemperature: Measurement(value: 26, unit: .celsius),
                        minTemperature: Measurement(value: 25.3, unit: .celsius),
                        averageTemperature: Measurement(value: 28.6, unit: .celsius),
                        maxWind: Measurement(value: 4.9, unit: .kilometersPerHour),
                        totalPrecipitation: Measurement(value: 3, unit: .millimeters),
                        totalSnow: Measurement(value: 0, unit: .centimeters),
                        averageVisibility: Measurement(value: 46.1, unit: .kilometers),
                        averageHumidity: 54,
                        dailyWillItRain: true,
                        dailyChanceOfRain: 54,
                        dailyWillItSnow: false,
                        dailyChanceOfSnow: 0,
                        description: "Partly Cloudy",
                        systemImage: "cloud.sun.fill",
                        uv: 4,
                        hours: (0...23).map { PreviewData.Forecast.Hour.sunny(hour: $0, addingDays: 6) }
                    )
                ]
            )
        }
        
        enum Hour {
            static func sunny(hour: Int, addingDays days: Int = 0) -> Weatherton.ForecastDay.Hour {
                let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: .now + (60 * 60 * Double(days)))!
                
                return ForecastDay.Hour(
                    time: date,
                    apparentTemperature: Measurement(value: 20, unit: .celsius),
                    dewPoint: Measurement(value: 12, unit: .celsius),
                    humidity: 30,
                    temperature: Measurement(value: 23, unit: .celsius),
                    description: "Sunny",
                    systemImage: "cloud.fill"
                )
            }
        }
    }
    
    enum Location {
        static var minneapolis: Weatherton.Location {
            Weatherton.Location(
                name: "Minneapolis",
                region: "Minnesota",
                country: "USA",
                latitude: 43.0,
                longitude: -93.0
            )
        }
        
        static var london: Weatherton.Location {
            Weatherton.Location(
                name: "London",
                region: "City of London, Greater London",
                country: "United Kingdom",
                latitude: 51.52,
                longitude: -0.11
            )
        }

        static var cupertino: Weatherton.Location {
            Weatherton.Location(
                name: "Cupertino",
                region: "California",
                country: "United States",
                latitude: 37.0,
                longitude: -110.0
            )
        }
    }
    
    enum Formatter {
        static var temperature: MeasurementFormatter {
            let formatter = MeasurementFormatter()
            formatter.numberFormatter.maximumFractionDigits = 0
            formatter.unitStyle = .short
            return formatter
        }
    }
}
#endif
