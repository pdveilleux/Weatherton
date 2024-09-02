//
//  WeatherDetailView.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/26/24.
//

import SwiftUI

struct WeatherDetailView: View {
    @State var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(viewModel.currentWeather.temperatureGradient)
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack {
                    if let message = viewModel.errorMessage {
                        MessageView(message: message)
                    }

                    currentConditionHeader
                    
                    if let forecast = viewModel.forecast {
                        HourlyForecastCard(forecast: forecast)
                        
                        DailyForecastCard(forecast: forecast)
                    }
                }
                .padding(.horizontal)
            }

            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle(viewModel.location.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    dismiss()
                } label: {
                    Label(Strings.locations, systemImage: "globe.americas.fill")
                }
                .tint(.primary)
                .accessibilityIdentifier("Dismiss")
            }
        }
        .task {
            await viewModel.getForecast()
        }
        .refreshable {
            Task {
                await viewModel.getForecast()
            }
        }
    }

    @ViewBuilder @MainActor
    private var currentConditionHeader: some View {
        VStack(spacing: 16) {
            VStack {
                HStack(alignment: .center, spacing: 20) {
                    if let image = viewModel.currentWeather.systemImage {
                        Image(systemName: image)
                            .font(.system(size: 48))
                    }
                    
                    Text(viewModel.currentWeather.apparentTemperature)
                        .font(.system(size: 64))
                        .fontWeight(.medium)
                }
                Text(viewModel.currentWeather.description)
                    .textCase(.uppercase)
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("\(viewModel.currentWeather.apparentTemperature), \(viewModel.currentWeather.description)")
            
            HStack(spacing: 40) {
                secondaryConditionLabel(value: viewModel.currentWeather.humidity, label: Strings.humidity)
                secondaryConditionLabel(value: viewModel.currentWeather.visibility, label: Strings.visibility)
                secondaryConditionLabel(
                    value: viewModel.currentWeather.windSpeedAndDirection,
                    label: Strings.wind,
                    accessibilityLabel: viewModel.currentWeather.windSpeedAndDirectionAccessibilityLabel
                )
            }
        }
        .padding()
        .shadow(color: colorScheme == .dark ? .black.opacity(0.2) : .clear, radius: 12)
        .accessibilityIdentifier("ConditionHeader")
    }

    @ViewBuilder
    private func secondaryConditionLabel(value: String, label: String, accessibilityLabel: String? = nil) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .fontWeight(.semibold)
            Text(label)
                .font(.caption2)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(label), \(accessibilityLabel ?? value)")
    }
}

#Preview {
    NavigationStack {
        WeatherDetailView(
            viewModel: WeatherDetailView.ViewModel(
                currentWeather: PreviewData.CurrentWeather.minneapolis,
                forecast: PreviewData.Forecast.minneapolis,
                weatherRepository: PreviewWeatherRepository(),
                temperatureFormatter: PreviewData.Formatter.temperature
            )
        )
    }
}
