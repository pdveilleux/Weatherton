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
                .foregroundStyle(Gradient(colors: [.red, .orange]))
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack {
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
    }
}

#Preview {
    NavigationStack {
        WeatherDetailView(
            viewModel: WeatherDetailView.ViewModel(
                currentWeather: PreviewData.CurrentWeather.minneapolis,
                weatherRepository: FakeWeatherRepository(),
                temperatureFormatter: PreviewData.Formatters.temperature
            )
        )
    }
}

extension WeatherDetailView {
    @Observable @MainActor
    final class ViewModel {
        private(set) var currentWeather: FormattedCurrentWeather
        var location: Location {
            currentWeather.location
        }

        private let weatherRepository: WeatherRepository
        private let temperatureFormatter: MeasurementFormatter

        init(
            currentWeather: CurrentWeather,
            weatherRepository: WeatherRepository,
            temperatureFormatter: MeasurementFormatter
        ) {
            self.currentWeather = FormattedCurrentWeather(currentWeather: currentWeather, formatter: temperatureFormatter)
            self.weatherRepository = weatherRepository
            self.temperatureFormatter = temperatureFormatter
        }
    }
}
