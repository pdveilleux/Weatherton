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
        VStack(alignment: .leading, spacing: 12) {
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
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    @ViewBuilder
    private func dayRow(day: FormattedForecastDay) -> some View {
        HStack(spacing: 20) {
            Group {
                Text(day.date)
                    .frame(minWidth: 44, alignment: .leading)
                if let icon = day.systemImage {
                    Image(systemName: icon)
                        .frame(minWidth: 44, alignment: .leading)
                        .font(.title3)
                        .symbolRenderingMode(.multicolor)
                }
                TemperatureBar(forecast: forecast, day: day)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Strings.dayRowAccessibilityLabel(
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
