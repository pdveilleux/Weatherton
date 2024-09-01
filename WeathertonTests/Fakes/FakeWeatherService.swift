//
//  FakeWeatherService.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/31/24.
//

import Foundation
@testable import Weatherton

@MainActor
final class FakeWeatherService: WeatherService {
    var getCurrentWeatherInput: Location?
    var getForecastInput: Location?
    var searchLocationsInput: String?

    var getCurrentWeatherResult: Result<CurrentWeather, Swift.Error>?
    var getForecastResult: Result<Forecast, Swift.Error>?
    var searchLocationsResult: Result<[Location], Swift.Error>?

    var getCurrentWeatherIterableResults: [Result<CurrentWeather, Swift.Error>]?
    var getCurrentWeatherIterableInputs: [Location]?

    enum Error: Swift.Error {
        case noValidResult
        case expectedError
    }
    
    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        // Check if setup for a single call
        if let getCurrentWeatherResult {
            getCurrentWeatherInput = location
            return try responseOrThrow(getCurrentWeatherResult)
        }
        // Check if setup for multiple calls
        else if var iterableResults = getCurrentWeatherIterableResults, !iterableResults.isEmpty {
            // Append or set input location
            if getCurrentWeatherIterableInputs != nil {
                getCurrentWeatherIterableInputs?.append(location)
            } else {
                getCurrentWeatherIterableInputs = [location]
            }
            // Remove first result and return response or throw
            let result = iterableResults.removeFirst()
            getCurrentWeatherIterableResults = iterableResults
            return try responseOrThrow(result)
        }
        // No valid result was configured before the call
        throw Error.noValidResult
    }
    
    func getForecast(location: Location) async throws -> Forecast {
        getForecastInput = location
        return try responseOrThrow(getForecastResult)
    }
    
    func searchLocations(query: String) async throws -> [Location] {
        searchLocationsInput = query
        return try responseOrThrow(searchLocationsResult)
    }

    private func responseOrThrow<T>(_ result: Result<T, Swift.Error>?) throws -> T {
        guard let result else {
            throw Error.noValidResult
        }

        switch result {
        case .success(let response):
            return response
        case .failure(let error):
            throw error
        }
    }
}
