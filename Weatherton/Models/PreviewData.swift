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
                location: Weatherton.Location(
                    name: "London",
                    region: "City of London, Greater London",
                    country: "United Kingdom",
                    latitude: 51.52,
                    longitude: -0.11)
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
                location: Weatherton.Location(
                    name: "Minneapolis",
                    region: "Minnesota",
                    country: "USA",
                    latitude: 51.52,
                    longitude: -0.11)
            )
        }
    }

    enum Formatters {
        static var temperature: MeasurementFormatter {
            let formatter = MeasurementFormatter()
            formatter.numberFormatter.maximumFractionDigits = 0
            formatter.unitStyle = .short
            return formatter
        }
    }
}
#endif
