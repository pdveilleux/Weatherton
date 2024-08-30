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
        VStack(alignment: .leading, spacing: 12) {
            CardHeader("24 Hour Forecast", systemImage: "clock")
                .padding(.horizontal)
                .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    ForEach(forecast.hourlyForecast, id: \.backingData.time) { hour in
                        VStack(spacing: 8) {
                            Text(hour.time)
                                .font(.caption)
                            if let icon = hour.systemImage {
                                Image(systemName: icon)
                                    .frame(minHeight: 32)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .symbolRenderingMode(.multicolor)
                            }
                            Text(hour.apparentTemperature)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .scrollIndicators(.hidden)
        }
        .background(.ultraThinMaterial)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
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


