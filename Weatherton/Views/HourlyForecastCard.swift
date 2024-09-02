//
//  HourlyForecastCard.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/30/24.
//

import SwiftUI

struct HourlyForecastCard: View {
    let forecast: FormattedForecast

    private enum Constants {
        static var title = "24 Hour Forecast"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CardHeader(Constants.title, systemImage: "clock")
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
                                    .frame(minHeight: 40)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .symbolRenderingMode(.multicolor)
                            }
                            Text(hour.apparentTemperature)
                                .fontWeight(.semibold)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel("\(hour.time), \(hour.apparentTemperature), \(hour.description)")
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


