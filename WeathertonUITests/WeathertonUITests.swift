//
//  WeathertonUITests.swift
//  WeathertonUITests
//
//  Created by Patrick Veilleux on 8/21/24.
//

import XCTest

final class WeathertonUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testAddLocationThenViewDetailsAndDeleteLocation() throws {
        let app = XCUIApplication()
        app.launch()

        let searchbar = app.searchFields.firstMatch
        searchbar.tap()
        searchbar.typeText("Minneapolis")
        
        let result = app.buttons["Minneapolis, Minnesota"]
        XCTAssertTrue(result.waitForExistence(timeout: 2))
        result.tap()

        let location = app.buttons["Location: Minneapolis"]
        XCTAssertTrue(location.waitForExistence(timeout: 2))
        location.tap()

        let dismiss = app.buttons["Dismiss"]
        XCTAssertTrue(dismiss.waitForExistence(timeout: 2))
        dismiss.tap()

        XCTAssertTrue(location.waitForExistence(timeout: 2))
        location.swipeLeft(velocity: 1000)

        let delete = app.buttons["Delete"]
        XCTAssertTrue(delete.waitForExistence(timeout: 2))
        delete.tap()

        XCTAssertFalse(location.exists)
    }
}
