//
//  RootWeatherView+ViewModel.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/25/24.
//

import Combine
import Foundation
import Observation

extension RootWeatherView {
    @Observable @MainActor
    final class ViewModel {
        private(set) var isLoading = false
        private(set) var weatherData: [FormattedCurrentWeather] = []
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
        var weatherDetailItem: CurrentWeather?
        
        private let weatherRepository: WeatherRepository
        private let preferenceManager: PreferenceManager
        private let temperatureFormatter: MeasurementFormatter
        private var cancellables: Set<AnyCancellable> = []

        enum Constants {
            static let debounceThreshold = 0.5
        }

        init(weatherRepository: WeatherRepository, preferenceManager: PreferenceManager, temperatureFormatter: MeasurementFormatter) {
            self.weatherRepository = weatherRepository
            self.preferenceManager = preferenceManager
            self.temperatureFormatter = temperatureFormatter
            
            searchText
                .debounce(for: .seconds(Constants.debounceThreshold), scheduler: RunLoop.main)
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
                weatherData = try await weatherRepository.getCurrentWeatherForSavedLocations().map { FormattedCurrentWeather(currentWeather: $0, formatter: temperatureFormatter) }
                print("Received weather data: \(weatherData)")
            } catch {
                print("Error fetching current weather data: \(error)")
            }
        }

        func addLocation(_ location: Location) async {
            do {
                let currentWeather = try await weatherRepository.getCurrentWeather(location: location)
                weatherData.append(FormattedCurrentWeather(currentWeather: currentWeather, formatter: temperatureFormatter))
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

        func removeLocations(at offsets: IndexSet) {
            let locations = weatherData
                .enumerated()
                .filter { offsets.contains($0.offset) }
                .map { $0.element.location }
            weatherData.remove(atOffsets: offsets)
            Task {
                await preferenceManager.removeSavedLocations(locations)
            }
        }
    }
}
