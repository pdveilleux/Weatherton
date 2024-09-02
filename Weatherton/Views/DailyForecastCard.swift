//
//  DailyForecastCard.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/29/24.
//

import SwiftUI

struct DailyForecastCard: View {
    let forecast: FormattedForecast
    
    var body: some View {
        VStack(alignment: .leading, spacing: Design.Spacing.small) {
            CardHeader(Strings.dailyForecast, systemImage: "calendar")
            
            VStack {
                ForEach(forecast.days, id: \.date) { day in
                    dayRow(day: day)
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .frame(maxWidth: .infinity)
        .clipShape(Design.ClipShape.standardRoundedRectangle)
    }

    @ViewBuilder
    private func dayRow(day: FormattedForecastDay) -> some View {
        HStack(spacing: Design.Spacing.standard) {
            Group {
                Text(day.date)
                    .frame(minWidth: Design.Sizing.standardMinimum, alignment: .leading)
                if let icon = day.systemImage {
                    Image(systemName: icon)
                        .frame(minWidth: Design.Sizing.standardMinimum, alignment: .leading)
                        .font(.title3)
                        .symbolRenderingMode(.multicolor)
                }
                TemperatureBar(forecast: forecast, day: day)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Strings.dayForecastAccessibilityLabel(
            date: day.dateAccessibilityLabel,
            description: day.description,
            low: day.minTemperature,
            high: day.maxTemperature
        ))
    }
}

#Preview {
    DailyForecastCard(
        forecast: FormattedForecast(
            forecast: PreviewData.Forecast.minneapolis,
            formatter: PreviewData.Formatter.temperature
        )
    )
}
