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
            Button {
                dismiss()
            } label: {
                Label("Locations", systemImage: "globe.americas.fill")
            }
            .tint(.primary)
        }
        .task {
            await viewModel.getForecast()
        }
    }

    @ViewBuilder @MainActor
    private var currentConditionHeader: some View {
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
                .padding(.bottom, 16)
            HStack(spacing: 40) {
                secondaryConditionLabel(value: viewModel.currentWeather.humidity, label: "Humidity")
                secondaryConditionLabel(value: viewModel.currentWeather.visibility, label: "Visibility")
                secondaryConditionLabel(value: viewModel.currentWeather.windSpeedAndDirection, label: "Wind")
            }
        }
        .padding()
        .shadow(color: colorScheme == .dark ? .black.opacity(0.2) : .clear, radius: 12)
    }

    @ViewBuilder
    private func secondaryConditionLabel(value: String, label: LocalizedStringKey) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .fontWeight(.semibold)
            Text(label)
                .font(.caption2)
        }
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
