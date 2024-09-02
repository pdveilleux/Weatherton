//
//  HourlyForecastCard.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/30/24.
//

import SwiftUI

struct HourlyForecastCard: View {
    let forecast: FormattedForecast
    
    var body: some View {
        VStack(alignment: .leading, spacing: Design.Spacing.small) {
            CardHeader(Strings.hourlyForecast, systemImage: "clock")
                .padding(.horizontal)
                .padding(.top)
                
            ScrollView(.horizontal) {
                HStack(spacing: Design.Spacing.reduced) {
                    ForEach(forecast.hourlyForecast, id: \.backingData.time) { hour in
                        VStack(spacing: Design.Spacing.verySmall) {
                            Text(hour.time)
                                .font(.caption)
                            if let icon = hour.systemImage {
                                Image(systemName: icon)
                                    .frame(minHeight: Design.Sizing.standardMinimum)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .symbolRenderingMode(.multicolor)
                            }
                            Text(hour.apparentTemperature)
                                .fontWeight(.semibold)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(Strings.hourForecastAccessibilityLabel(
                            time: hour.time,
                            temperature: hour.apparentTemperature,
                            description: hour.description
                        ))
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .scrollIndicators(.hidden)
        }
        .background(.ultraThinMaterial)
        .frame(maxWidth: .infinity)
        .clipShape(Design.ClipShape.standardRoundedRectangle)
        .accessibilityElement(children: .contain)
    }
}

#Preview {
    HourlyForecastCard(
        forecast: FormattedForecast(
            forecast: PreviewData.Forecast.minneapolis,
            formatter: PreviewData.Formatter.temperature
        )
    )
}


