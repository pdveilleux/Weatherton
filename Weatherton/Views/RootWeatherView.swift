//
//  RootWeatherView.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Combine
import Observation
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
                        }
                    }
                    .padding(.horizontal)
                }
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
}

extension RootWeatherView {
    @Observable @MainActor
    final class ViewModel {
        private(set) var isLoading = false
        private(set) var weatherData: [CurrentWeather] = []
        private(set) var locationResults: [Location] = []
        var searchText: CurrentValueSubject<String, Never> = .init("")
        var isSearching = false {
            didSet {
                if !isSearching {
                    locationResults = []
                    searchText.send("")
                }
            }
        }
        
        private let weatherRepository: WeatherRepository
        private let preferenceManager: PreferenceManager
        private var cancellables: Set<AnyCancellable> = []

        init(weatherRepository: WeatherRepository, preferenceManager: PreferenceManager) {
            self.weatherRepository = weatherRepository
            self.preferenceManager = preferenceManager
            
            searchText
                .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
                .removeDuplicates()
                .sink { [weak self] query in
                    guard !query.isEmpty else {
                        self?.locationResults = []
                        return
                    }
                    Task {
                        await self?.searchLocations(query: query)
                    }
                }.store(in: &cancellables)
        }

        func getWeatherData() async {
            isLoading = true
            defer {
                isLoading = false
            }

            do {
                weatherData = try await weatherRepository.getCurrentWeatherForSavedLocations()
                print("Received weather data: \(weatherData)")
            } catch {
                print("Error fetching current weather data: \(error)")
            }
        }

        func addLocation(_ location: Location) async {
            do {
                let currentWeather = try await weatherRepository.getCurrentWeather(location: location)
                weatherData.append(currentWeather)
                await preferenceManager.saveLocation(location)
                print("Received weather data: \(weatherData)")
            } catch {
                print("Error fetching current weather data: \(error)")
            }
        }

        func searchLocations(query: String) async {
            guard !query.isEmpty else { return }
            do {
                locationResults = try await weatherRepository.searchLocations(query: query)
                print("Received locations: \(locationResults.map(\.name))")
                print("Searching \(isSearching)")
            } catch {
                print("Error searching locations: \(error)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        RootWeatherView(viewModel: RootWeatherView.ViewModel(weatherRepository: FakeWeatherRepository(), preferenceManager: DefaultPreferenceManager()))
    }
}
