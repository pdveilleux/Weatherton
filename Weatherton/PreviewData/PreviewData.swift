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
                updatedDate: .now - (60 * 10),
                condition: WeatherCondition(
                    description: "Partly Cloudy",
                    systemImage: "cloud.sun.fill"
                ),
                location: PreviewData.Location.london
            )
        }

        static var minneapolis: Weatherton.CurrentWeather {
            Weatherton.CurrentWeather(
                id: UUID(),
                apparentTemperature: Measurement(value: 32.4, unit: .celsius),
                dewPoint: Measurement(value: 19.2, unit: .celsius),
                humidity: 70,
                temperature: Measurement(value: 31.0, unit: .celsius),
                updatedDate: .now - (60 * 10),
                condition: WeatherCondition(
                    description: "Partly Cloudy",
                    systemImage: "cloud.sun.fill"
                ),
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
                        maxTemp: Measurement(value: 32.4, unit: .celsius),
                        minTemp: Measurement(value: 25.3, unit: .celsius),
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
                        condition: WeatherCondition(
                            description: "Partly Cloudy",
                            systemImage: "cloud.sun.fill"
                        ),
                        uv: 4,
                        hours: []
                    )
                ]
            )
        }
    }

    enum Location {
        static var minneapolis: Weatherton.Location {
            Weatherton.Location(
                name: "Minneapolis",
                region: "Minnesota",
                country: "USA",
                latitude: 51.52,
                longitude: -0.11
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
