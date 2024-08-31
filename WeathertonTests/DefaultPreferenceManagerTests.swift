//
//  DefaultPreferenceManagerTests.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/30/24.
//

import XCTest
@testable import Weatherton

final class DefaultPreferenceManagerTests: XCTestCase {
    private var fakeUserDefaults: FakeUserDefaults?
    private var preferenceManager: DefaultPreferenceManager?

    @MainActor
    override func setUpWithError() throws {
        let fakeUserDefaults = FakeUserDefaults()
        preferenceManager = DefaultPreferenceManager(store: fakeUserDefaults)
        self.fakeUserDefaults = fakeUserDefaults
    }

    override func tearDownWithError() throws {
        fakeUserDefaults = nil
        preferenceManager = nil
    }

    @MainActor
    func testSaveLocation() throws {
        // Given
        // - No existing location is saved

        // When
        // - Save new location
        let new = PreviewData.Location.minneapolis
        preferenceManager?.saveLocation(new)
        
        // Then
        // - The single location is saved
        let expectedLocations = [new]
        let resultInput = try XCTUnwrap(fakeUserDefaults?.setValueForKeyInput)
        let resultData = try XCTUnwrap(resultInput.value as? Data)
        let locations = try JSONDecoder().decode([Location].self, from: resultData)

        XCTAssertEqual(resultInput.key, "SavedLocations")
        XCTAssertEqual(locations, expectedLocations)
    }

    @MainActor
    func testSaveLocationWithExisting() throws {
        // Given
        // - A location is already saved
        let existing = PreviewData.Location.london
        let data = try JSONEncoder().encode([existing])
        fakeUserDefaults?.dataForKeyResponse = data

        // When
        // - Save new location
        let new = PreviewData.Location.minneapolis
        preferenceManager?.saveLocation(new)
        
        // Then
        // - Both locations are saved together
        let expectedLocations = [existing, new]
        let resultInput = try XCTUnwrap(fakeUserDefaults?.setValueForKeyInput)
        let resultData = try XCTUnwrap(resultInput.value as? Data)
        let locations = try JSONDecoder().decode([Location].self, from: resultData)

        XCTAssertEqual(resultInput.key, "SavedLocations")
        XCTAssertEqual(locations, expectedLocations)
    }

    @MainActor
    func testGetSavedLocations() throws {
        // Given
        // - Locations are saved
        let existing = [PreviewData.Location.london, PreviewData.Location.minneapolis]
        let data = try JSONEncoder().encode(existing)
        fakeUserDefaults?.dataForKeyResponse = data

        // When
        // - Retrieving saved locations
        let savedLocations = preferenceManager?.getSavedLocations()
        
        // Then
        // - Retrieved locations match what was saved
        XCTAssertEqual(savedLocations, existing)
    }

    @MainActor
    func testRemoveSavedLocations() throws {
        // Given
        // - Locations are saved
        let existing = [
            PreviewData.Location.london,
            PreviewData.Location.minneapolis,
            PreviewData.Location.cupertino
        ]
        let data = try JSONEncoder().encode(existing)
        fakeUserDefaults?.dataForKeyResponse = data

        // When
        // - Locations are removed
        let removedLocations = [
            PreviewData.Location.london,
            PreviewData.Location.cupertino
        ]
        preferenceManager?.removeSavedLocations(removedLocations)

        // Then
        // - Remaining locations are saved
        let expectedLocations = [PreviewData.Location.minneapolis]
        let resultInput = try XCTUnwrap(fakeUserDefaults?.setValueForKeyInput)
        let resultData = try XCTUnwrap(resultInput.value as? Data)
        let locations = try JSONDecoder().decode([Location].self, from: resultData)

        XCTAssertEqual(resultInput.key, "SavedLocations")
        XCTAssertEqual(locations, expectedLocations)
    }
}
