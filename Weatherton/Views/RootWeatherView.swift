//
//  RootWeatherView.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Observation
import SwiftUI

@Observable @MainActor
final class RootWeatherViewModel {
    private(set) var isLoading = false
    private(set) var weatherData: [CurrentWeather] = []
    
    private let weatherRepository: WeatherRepository

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func getWeatherData() async {
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            let currentWeather = try await weatherRepository.getCurrentWeather()
            weatherData = [currentWeather]
            print("Received weather data: \(weatherData)")
        } catch {
            print("Error occurred \(error)")
        }
    }
}

struct RootWeatherView: View {
    let viewModel: RootWeatherViewModel
    let temperatureFormatter: MeasurementFormatter = {
        var formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitStyle = .short
        return formatter
    }()

    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()

            ScrollView {
                Grid {
                    ForEach(viewModel.weatherData, id: \.self) { weather in
                        VStack(alignment: .leading) {
                            if let icon = weather.condition.systemImage {
                                Image(systemName: icon)
                                    .font(.title)
                            }
                            Text(temperatureFormatter.string(from: weather.apparentTemperature))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                            Text(weather.location.name)
                                .font(.subheadline)
                                .fontDesign(.rounded)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(12)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .padding()
                    }
                }
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle("Current Weather")
        .refreshable {
            Task {
                await viewModel.getWeatherData()
            }
        }
        .task {
            await viewModel.getWeatherData()
        }
    }
}

#Preview {
    RootWeatherView(viewModel: RootWeatherViewModel(weatherRepository: FakeWeatherRepository()))
}
