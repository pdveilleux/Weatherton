//
//  WeatherCondition.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/22/24.
//

import Foundation

struct WeatherCondition: Hashable {
    /// Weather condition description.
    let description: String
    /// The name of the system symbol which represents the condition.
    let systemImage: String?
}
