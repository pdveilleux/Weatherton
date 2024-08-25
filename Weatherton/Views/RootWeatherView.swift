//
//  RootWeatherView.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import SwiftUI

struct RootWeatherView: View {
    @State var viewModel: ViewModel
    let temperatureFormatter: MeasurementFormatter = {
        var formatter = MeasurementFormatter()
        formatter.numberFormatter.maximumFractionDigits = 0
        formatter.unitStyle = .short
        return formatter
    }()

    var body: some View {
        ZStack {
            if viewModel.isSearching {
                List(viewModel.locationResults, id: \.self) { location in
                    Button {
                        viewModel.isSearching = false
                        Task {
                            await viewModel.addLocation(location)
                        }
                    } label: {
                        Text("\(location.name), \(location.region)")
                    }
                }
            } else {
                List(viewModel.weatherData, id: \.self) { weather in
                    NavigationLink {
                        Text(weather.location.name)
                    } label: {
                        weatherRow(weather)
                    }
                }
                .listStyle(.plain)
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationTitle("Current Weather")
        .searchable(
            text: Binding(
                get: { viewModel.searchText.value },
                set: { viewModel.searchText.send($0) }),
            isPresented: $viewModel.isSearching
        )
        .refreshable {
            Task {
                await viewModel.getWeatherData()
            }
        }
        .task {
            await viewModel.getWeatherData()
        }
    }

    @ViewBuilder
    private func weatherRow(_ weather: CurrentWeather) -> some View {
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
    }
}

#Preview {
    NavigationStack {
        RootWeatherView(viewModel: RootWeatherView.ViewModel(weatherRepository: FakeWeatherRepository(), preferenceManager: DefaultPreferenceManager()))
    }
}
