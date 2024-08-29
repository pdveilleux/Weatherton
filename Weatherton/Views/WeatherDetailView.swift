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

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(viewModel.currentWeather.temperatureGradient)
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack {
                    currentConditionHeader
                }
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
                if let image = viewModel.currentWeather.condition.systemImage {
                    Image(systemName: image)
                        .font(.system(size: 48))
                        .symbolRenderingMode(.multicolor)
                }
                
                VStack(spacing: -4) {
                    Text(viewModel.currentWeather.apparentTemperature)
                        .font(.system(size: 64))
                        .fontWeight(.medium)
                }
            }
            Text(viewModel.currentWeather.condition.description)
                .textCase(.uppercase)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.bottom, 16)
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        WeatherDetailView(
            viewModel: WeatherDetailView.ViewModel(
                currentWeather: PreviewData.CurrentWeather.minneapolis,
                forecast: PreviewData.Forecast.minneapolis,
                weatherRepository: FakeWeatherRepository(),
                temperatureFormatter: PreviewData.Formatter.temperature
            )
        )
    }
}
