//
//  DefaultWeatherRepositoryTests.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/31/24.
//

import XCTest
@testable import Weatherton

final class DefaultWeatherRepositoryTests: XCTestCase {
    private var fakeWeatherService: FakeWeatherService?
    private var fakePreferenceManager: FakePreferenceManager?
    private var weatherRepository: DefaultWeatherRepository?

    @MainActor
    override func setUpWithError() throws {
        let fakeWeatherService = FakeWeatherService()
        let fakePreferenceManager = FakePreferenceManager()
        weatherRepository = DefaultWeatherRepository(
            weatherService: fakeWeatherService,
            preferenceManager: fakePreferenceManager
        )

        self.fakeWeatherService = fakeWeatherService
        self.fakePreferenceManager = fakePreferenceManager
    }

    override func tearDownWithError() throws {
        fakeWeatherService = nil
        fakePreferenceManager = nil
        weatherRepository = nil
    }

    @MainActor
    func testGetCurrentWeatherSuccess() async throws {
        // Given
        // - The weather service has weather data
        let currentWeather = PreviewData.CurrentWeather.minneapolis
        fakeWeatherService?.getCurrentWeatherResult = .success(currentWeather)

        // When
        // - Fetch the current weather for a location
        let location = PreviewData.Location.minneapolis
        let result = try await weatherRepository?.getCurrentWeather(location: location)

        // Then
        // - The result matches what was expected
        XCTAssertEqual(result, currentWeather)
        let input = try XCTUnwrap(fakeWeatherService?.getCurrentWeatherInput)
        XCTAssertEqual(input, location)
    }

    @MainActor
    func testGetCurrentWeatherError() async throws {
        // Given
        // - The weather service will throw an error
        let inputError = FakeWeatherService.Error.expectedError
        fakeWeatherService?.getCurrentWeatherResult = .failure(inputError)

        // When
        // - Fetch the current weather for a location
        let location = PreviewData.Location.minneapolis
        do {
            _ = try await weatherRepository?.getCurrentWeather(location: location)
            XCTFail("getCurrentWeather should have thrown.")
        } catch {
            // Then
            // - The resulting error matches what was expected
            XCTAssertEqual(error as? FakeWeatherService.Error, inputError)
            let input = try XCTUnwrap(fakeWeatherService?.getCurrentWeatherInput)
            XCTAssertEqual(input, location)
        }
    }

    @MainActor
    func testGetCurrentWeatherForSavedLocationsSuccess() async throws {
        // Given
        // - The weather service has weather data
        // - The weather data is unsorted
        let currentWeather1 = PreviewData.CurrentWeather.minneapolis
        let currentWeather2 = PreviewData.CurrentWeather.london
        fakeWeatherService?.getCurrentWeatherIterableResults = [.success(currentWeather2), .success(currentWeather1)]

        let location1 = PreviewData.Location.minneapolis
        let location2 = PreviewData.Location.london
        fakePreferenceManager?.getSavedLocationsResponse = [location1, location2]

        // When
        // - Fetch the current weather for saved locations
        let result = try await weatherRepository?.getCurrentWeatherForSavedLocations()

        // Then
        // - The result matches what was expected
        // - The result is sorted according to the saved locations
        XCTAssertEqual(result, [currentWeather1, currentWeather2])
        let inputs = try XCTUnwrap(fakeWeatherService?.getCurrentWeatherIterableInputs)
        XCTAssertEqual(Set(inputs), Set([location1, location2]))
    }

    @MainActor
    func testGetCurrentWeatherForSavedLocationsSingleError() async throws {
        // Given
        // - The weather service has weather data
        // - The weather service will return one error and one weather
        let currentWeather = PreviewData.CurrentWeather.minneapolis
        let inputError = FakeWeatherService.Error.expectedError
        fakeWeatherService?.getCurrentWeatherIterableResults = [.success(currentWeather), .failure(inputError)]

        let location1 = PreviewData.Location.minneapolis
        let location2 = PreviewData.Location.london
        fakePreferenceManager?.getSavedLocationsResponse = [location1, location2]

        // When
        // - Fetch the current weather for saved locations
        do {
            _ = try await weatherRepository?.getCurrentWeatherForSavedLocations()
            XCTFail("getCurrentWeatherForSavedLocations should have thrown")
        } catch {
            // Then
            // - The resulting error matches what was expected
            XCTAssertEqual(error as? FakeWeatherService.Error, inputError)
            let inputs = try XCTUnwrap(fakeWeatherService?.getCurrentWeatherIterableInputs)
            XCTAssertEqual(Set(inputs), Set([location1, location2]))
        }
    }

    @MainActor
    func testGetCurrentWeatherForSavedLocationsAllErrors() async throws {
        // Given
        // - The weather service has weather data
        // - The weather service will return errors
        let inputError = FakeWeatherService.Error.expectedError
        fakeWeatherService?.getCurrentWeatherIterableResults = [.failure(inputError), .failure(inputError)]

        let location1 = PreviewData.Location.minneapolis
        let location2 = PreviewData.Location.london
        fakePreferenceManager?.getSavedLocationsResponse = [location1, location2]

        // When
        // - Fetch the current weather for saved locations
        do {
            _ = try await weatherRepository?.getCurrentWeatherForSavedLocations()
            XCTFail("getCurrentWeatherForSavedLocations should have thrown")
        } catch {
            // Then
            // - The resulting error matches what was expected
            XCTAssertEqual(error as? FakeWeatherService.Error, inputError)
            let inputs = try XCTUnwrap(fakeWeatherService?.getCurrentWeatherIterableInputs)
            XCTAssertEqual(Set(inputs), Set([location1, location2]))
        }
    }

    @MainActor
    func testGetForecastSuccess() async throws {
        // Given
        // - The weather service has forecast data
        let forecast = PreviewData.Forecast.minneapolis
        fakeWeatherService?.getForecastResult = .success(forecast)

        // When
        // - Fetch the forecast for a location
        let location = PreviewData.Location.minneapolis
        let result = try await weatherRepository?.getForecast(location: location)

        // Then
        // - The result matches what was expected
        XCTAssertEqual(result, forecast)
        let input = try XCTUnwrap(fakeWeatherService?.getForecastInput)
        XCTAssertEqual(input, location)
    }

    @MainActor
    func testGetForecastError() async throws {
        // Given
        // - The weather service will throw an error
        let inputError = FakeWeatherService.Error.expectedError
        fakeWeatherService?.getForecastResult = .failure(inputError)

        // When
        // - Fetch the current weather for a location
        let location = PreviewData.Location.minneapolis
        do {
            _ = try await weatherRepository?.getForecast(location: location)
            XCTFail("getForecast should have thrown.")
        } catch {
            // Then
            // - The resulting error matches what was expected
            XCTAssertEqual(error as? FakeWeatherService.Error, inputError)
            let input = try XCTUnwrap(fakeWeatherService?.getForecastInput)
            XCTAssertEqual(input, location)
        }
    }

    @MainActor
    func testSearchLocationsSuccess() async throws {
        // Given
        // - The weather service has location data
        let location1 = PreviewData.Location.minneapolis
        let location2 = PreviewData.Location.london
        let location3 = PreviewData.Location.cupertino
        fakeWeatherService?.searchLocationsResult = .success([location1, location2, location3])

        // When
        // - Search for locations
        let query = "Minneapolis"
        let result = try await weatherRepository?.searchLocations(query: query)

        // Then
        // - The result matches what was expected
        XCTAssertEqual(result, [location1, location2, location3])
        let input = try XCTUnwrap(fakeWeatherService?.searchLocationsInput)
        XCTAssertEqual(input, query)
    }

    @MainActor
    func testSearchLocationsError() async throws {
        // Given
        // - The weather service will return an error
        let inputError = FakeWeatherService.Error.expectedError
        fakeWeatherService?.searchLocationsResult = .failure(inputError)

        // When
        // - Fetch the current weather for a location
        let query = "Minneapolis"
        do {
            _ = try await weatherRepository?.searchLocations(query: query)
            XCTFail("searchLocations should have thrown.")
        } catch {
            // Then
            // - The resulting error matches what was expected
            XCTAssertEqual(error as? FakeWeatherService.Error, inputError)
            let input = try XCTUnwrap(fakeWeatherService?.searchLocationsInput)
            XCTAssertEqual(input, query)
        }
    }
}
