//
//  WeatherAPIClientTests.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/30/24.
//

import XCTest
@testable import Weatherton

final class WeatherAPIClientTests: XCTestCase {
    var client: WeatherAPIClient?
    let uuid = UUID(uuidString: "00000000-0000-0000-0000-000000000001")

    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [FakeURLProtocol.self]
        let session = URLSession(configuration: configuration)
        let uuid = try XCTUnwrap(uuid)
        let uuidFactory = UUIDFactory { uuid }
        client = WeatherAPIClient(session: session, uuidFactory: uuidFactory)
        StubExpectation.uuidFactory = uuidFactory
    }

    override func tearDownWithError() throws {
        client = nil
    }

    func testGetCurrentWeather() async throws {
        // Given
        // - There is current weather (in this case getting stubbed)
        try prepareStub("CurrentWeather")

        // When
        // - Fetch current weather
        let weather = try await client?.getCurrentWeather(location: PreviewData.Location.london)

        // Then
        // - Result equals expectation
        let expected = StubExpectation.currentWeather
        XCTAssertEqual(weather, expected)
    }

    func testGetForecast() async throws {
        // Given
        // - There is a forecast (in this case getting stubbed)
        try prepareStub("Forecast")

        // When
        // - Fetch the forecast
        let forecast = try await client?.getForecast(location: PreviewData.Location.minneapolis)

        // Then
        // - Result equals expectation
        let expected = StubExpectation.forecast
        XCTAssertEqual(forecast, expected)
    }

    func testSearchLocations() async throws {
        // Given
        // - There are locations (in this case getting stubbed)
        try prepareStub("Search")

        // When
        // - Search locations
        let forecast = try await client?.searchLocations(query: "London")

        // Then
        // - Result equals expectation
        let expected = StubExpectation.searchLocations
        XCTAssertEqual(forecast, expected)
    }
}

extension WeatherAPIClientTests {
    func prepareStub(_ filename: String) throws {
        let data = try StubLoader().jsonDataFor(filename: filename)
        FakeURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                throw FakeURLProtocol.Error.noURL
            }
            guard let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
                throw FakeURLProtocol.Error.unableToMakeResponse
            }
            return (response, data)
        }
    }
}
