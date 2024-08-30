//
//  DefaultPreferenceManagerTests.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/30/24.
//

import XCTest
@testable import Weatherton

final class DefaultPreferenceManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testSaveLocation() throws {
        // Given
        let fakeUserDefaults = FakeUserDefaults()
        let manager = DefaultPreferenceManager(store: fakeUserDefaults)
        let location = PreviewData.Location.london
        let data = try JSONEncoder().encode([location])
        fakeUserDefaults.dataForKeyResponse = data
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
