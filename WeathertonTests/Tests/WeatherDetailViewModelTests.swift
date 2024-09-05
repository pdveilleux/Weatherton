//
//  WeatherDetailViewModelTests.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 9/5/24.
//

import XCTest
@testable import Weatherton

final class WeatherDetailViewModelTests: XCTestCase {
    var weatherRepository: FakeWeatherRepository?
    var viewModel: WeatherDetailView.ViewModel?
    var formatter: MeasurementFormatter?

    @MainActor
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let weatherRepository = FakeWeatherRepository()
        let formatter = MeasurementFormatter()
        let logger = TestData.Logging.logger
        
        let viewModel = WeatherDetailView.ViewModel(
            currentWeather: TestData.CurrentWeather.minneapolis,
            weatherRepository: weatherRepository,
            temperatureFormatter: formatter,
            logger: logger
        )

        self.weatherRepository = weatherRepository
        self.viewModel = viewModel
        self.formatter = formatter
    }

    override func tearDownWithError() throws {
        weatherRepository = nil
        viewModel = nil
        formatter = nil
    }

    @MainActor
    func testInit() async throws {
        // Given
        // - Specified dependencies
        let weatherRepository = FakeWeatherRepository()
        let formatter = MeasurementFormatter()
        let logger = TestData.Logging.logger
        let forecast = TestData.Forecast.minneapolis
        
        // When
        // - The view model is initialized with a forecast
        let viewModel = WeatherDetailView.ViewModel(
            currentWeather: TestData.CurrentWeather.minneapolis,
            forecast: forecast,
            weatherRepository: weatherRepository,
            temperatureFormatter: formatter,
            logger: logger
        )

        // Then
        // - The view model sets it's formatted forecast
        let result = try XCTUnwrap(viewModel.forecast)
        let expected = FormattedForecast(forecast: forecast, formatter: formatter)
        XCTAssertEqual(result, expected)
    }

    @MainActor 
    func testGetForecastSuccess() async throws {
        // Given
        // - The weather repository will return a valid result.
        let forecast = TestData.Forecast.minneapolis
        weatherRepository?.getForecastResult = .success(forecast)

        // When
        // - Fetch the forecast
        await viewModel?.getForecast()

        // Then
        // - Result equals expectation
        // - Error message is nil
        let result = try XCTUnwrap(viewModel?.forecast)
        let formatter = try XCTUnwrap(self.formatter)
        let expected = FormattedForecast(forecast: forecast, formatter: formatter)
        XCTAssertEqual(result, expected)
        XCTAssertNil(viewModel?.errorMessage)
    }

    @MainActor
    func testGetForecastFailure() async throws {
        // Given
        // - The weather repository will return a valid result.
        weatherRepository?.getForecastResult = .failure(WeatherServiceError.notConnectedToInternet)

        // When
        // - Fetch the forecast
        await viewModel?.getForecast()

        // Then
        // - View model is nil
        // - Error message equals expectation
        XCTAssertEqual(viewModel?.errorMessage, Message.notConnectedToInternet)
        XCTAssertNil(viewModel?.forecast)
    }
}
