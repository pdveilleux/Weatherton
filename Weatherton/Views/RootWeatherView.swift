//
//  RootWeatherView.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import SwiftUI

struct RootWeatherView: View {
    @State var viewModel: ViewModel
    @EnvironmentObject var dependencyJar: DependencyJar

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
                List {
                    ForEach(viewModel.weatherData, id: \.self) { weather in
                        Button {
                            viewModel.weatherDetailItem = weather.backingData
                        } label: {
                            weatherRow(weather)
                        }
                        .tint(.primary)
                        .listRowSeparator(.hidden)
                    }
                    .onDelete(perform: delete)
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
        .fullScreenCover(item: $viewModel.weatherDetailItem) { weather in
            NavigationStack {
                WeatherDetailView(
                    viewModel: dependencyJar.viewModelFactory.buildWeatherDetailViewModel(currentWeather: weather)
                )
            }
        }
        .task {
            await viewModel.getWeatherData()
        }
    }

    @ViewBuilder
    private func weatherRow(_ weather: FormattedCurrentWeather) -> some View {
        VStack(alignment: .leading) {
            if let icon = weather.systemImage {
                Image(systemName: icon)
                    .font(.title)
            }
            Text(weather.apparentTemperature)
                .font(.largeTitle)
                .fontWeight(.bold)
                .fontDesign(.rounded)
            Text(weather.location.name)
                .font(.subheadline)
                .fontDesign(.rounded)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(LinearGradient(gradient: weather.temperatureGradient, startPoint: .leading, endPoint: .trailing))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
    }

    @MainActor func delete(at offsets: IndexSet) {
        viewModel.removeLocations(at: offsets)
    }
}

#Preview {
    NavigationStack {
        RootWeatherView(
            viewModel: RootWeatherView.ViewModel(
                weatherRepository: FakeWeatherRepository(),
                preferenceManager: DefaultPreferenceManager(),
                temperatureFormatter: PreviewData.Formatter.temperature
            )
        )
    }
}
