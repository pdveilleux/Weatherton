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
            header
            
            VStack {
                ForEach(forecast.days, id: \.date) { day in
                    dayRow(day: day)
                }
            }
        }
        .padding()
        .background(.thickMaterial)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    @ViewBuilder
    private var header: some View {
        Label("Daily Forecast", systemImage: "calendar")
            .textCase(.uppercase)
            .font(.caption)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
        Divider()
    }

    @ViewBuilder
    private func dayRow(day: FormattedForecastDay) -> some View {
        HStack(spacing: 40) {
            Group {
                Text("Mon")
                if let icon = day.condition.systemImage {
                    Image(systemName: icon)
                }
                temperatureBar(day: day)
            }
        }
    }

    @ViewBuilder
    private func temperatureBar(day: FormattedForecastDay) -> some View {
        HStack(alignment: .center) {
            Text(day.minTemperature)
                .fontWeight(.semibold)
            GeometryReader { geometry in
                if let offset = getOffset(forecast: forecast, day: day, geometry: geometry),
                    let width = getWidth(forecast: forecast, day: day, geometry: geometry) {
                    ZStack {
                        Capsule()
                            .frame(maxWidth: .infinity, maxHeight: 6)
                            .foregroundStyle(Color.gray.opacity(0.2))
                        Capsule()
                            .foregroundStyle(LinearGradient(colors: [.blue, .green, .yellow, .orange, .red], startPoint: .leading, endPoint: .trailing))
                            .mask {
                                Capsule()
                                    .frame(width: width, height: 6)
                                    .offset(x: offset)
                                    .foregroundStyle(Color.blue)
                            }
                    }
                    .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).midY)
                }
            }
            
            Text(day.maxTemperature)
                .fontWeight(.semibold)
        }
        .frame(maxWidth: .infinity)
    }

    private func getOffset(forecast: FormattedForecast, day: FormattedForecastDay, geometry: GeometryProxy) -> CGFloat? {
        guard let forecastRange = forecast.range, let minimimMinTemp = forecast.minimimMinTemp else {
            return nil
        }
        let coefficient = geometry.size.width / forecastRange
        let minTempDelta = day.backingData.minTemperature.value - minimimMinTemp
        let rangeDelta = forecastRange - day.temperatureRange
        let rangeOffset = -(rangeDelta / 2)
        let offset = (rangeOffset + minTempDelta) * coefficient
        return offset
    }

    private func getWidth(forecast: FormattedForecast, day: FormattedForecastDay, geometry: GeometryProxy) -> CGFloat? {
        guard let forecastRange = forecast.range else {
            return nil
        }
        return (day.temperatureRange / forecastRange) * geometry.size.width
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
