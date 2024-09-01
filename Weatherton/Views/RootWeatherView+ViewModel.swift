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
        private(set) var errorMessage: Message?
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

            await catchHandledErrors {
                weatherData = try await weatherRepository.getCurrentWeatherForSavedLocations().map { FormattedCurrentWeather(currentWeather: $0, formatter: temperatureFormatter) }
            }
        }

        func addLocation(_ location: Location) async {
            guard !weatherData.map(\.location).contains(location) else {
                return
            }

            await catchHandledErrors {
                let currentWeather = try await weatherRepository.getCurrentWeather(location: location)
                weatherData.append(FormattedCurrentWeather(currentWeather: currentWeather, formatter: temperatureFormatter))
                await preferenceManager.saveLocation(location)
            }
        }

        func searchLocations(query: String) async {
            guard !query.isEmpty else { return }
            await catchHandledErrors {
                locationResults = try await weatherRepository.searchLocations(query: query)
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

        private func catchHandledErrors(_ block: () async throws -> Void) async {
            do {
                try await block()
                errorMessage = nil
            } catch WeatherServiceError.notConnectedToInternet {
                errorMessage = .notConnectedToInternet
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}
