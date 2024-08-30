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
            CardHeader("Daily Forecast", systemImage: "calendar")
            
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
                temperatureBar(day: day)
            }
        }
    }

    @ViewBuilder
    private func temperatureBar(day: FormattedForecastDay) -> some View {
        HStack(alignment: .center) {
            Text(day.minTemperature)
                .fontWeight(.semibold)
                .frame(minWidth: 32, alignment: .leading)
            GeometryReader { geometry in
                if let offset = getOffset(forecast: forecast, day: day, width: geometry.size.width),
                   let width = getWidth(forecast: forecast, day: day, width: geometry.size.width) {
                    ZStack {
                        Capsule()
                            .frame(maxWidth: .infinity, maxHeight: 6)
                            .foregroundStyle(Color.gray.opacity(0.2))
                        Capsule()
                            .foregroundStyle(LinearGradient(
                                colors: [.blue, .green, .yellow, .orange, .red],
                                startPoint: .leading, endPoint: .trailing
                            ))
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
                .frame(minWidth: 32, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
    }

    /// Determines the horizontal offset for the masking layer of the temperature bar.
    private func getOffset(forecast: FormattedForecast, day: FormattedForecastDay, width: Double) -> CGFloat? {
        guard let forecastRange = forecast.temperatureRange, let minimimMinTemp = forecast.minimimMinTemp else {
            return nil
        }
        // Get the portion of the width which represents each degree. This will be used as a unit.
        let coefficient = width / forecastRange
        // The difference between the day's minimum temperature and the week's.
        let minTempDelta = day.backingData.minTemperature.value - minimimMinTemp
        // The difference between the week's temperature range and the day's.
        let rangeDelta = forecastRange - day.temperatureRange
        // Because the mask layer starts horizontally centered which leaves a gap on each side and we want to compensate for that by aligning it to the left we divide the rangeDelta by 2 and get the resulting negative value.
        let rangeOffset = -(rangeDelta / 2)
        // Add the minTempDelta to compensate for the day's minimum temp being greater than the week's and multiply by the coefficient.
        return (rangeOffset + minTempDelta) * coefficient
    }

    /// Determines the width for the masking layer of the temperature bar.
    private func getWidth(forecast: FormattedForecast, day: FormattedForecastDay, width: Double) -> CGFloat? {
        guard let forecastRange = forecast.temperatureRange else {
            return nil
        }
        // Get a proportion of the day's temperature range to the week's and multiple that by the width of the available space.
        return (day.temperatureRange / forecastRange) * width
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
