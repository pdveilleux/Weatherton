//
//  FakeWeatherRepository.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 9/5/24.
//

import Foundation
@testable import Weatherton

@MainActor
final class FakeWeatherRepository: WeatherRepository {
    var getForecastResult: Result<Forecast, Swift.Error>?

    enum Error: Swift.Error {
        case noValidResult
        case expectedError
    }

    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        throw Error.noValidResult
    }

    func getCurrentWeatherForSavedLocations() async throws -> [CurrentWeather] {
        throw Error.noValidResult
    }

    func getForecast(location: Location) async throws -> Forecast {
        try responseOrThrow(getForecastResult)
    }

    func searchLocations(query: String) async throws -> [Location] {
        throw Error.noValidResult
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
