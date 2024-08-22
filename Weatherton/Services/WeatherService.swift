//
//  WeatherService.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

protocol WeatherService {
    func getCurrentWeather(query: String) async throws -> CurrentWeather
}

struct WeatherServiceError: Error {
    
}
