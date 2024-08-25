//
//  WeatherAPIClient.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

final class WeatherAPIClient: WeatherService {
    private let session: URLSession

    private var baseURL: URL {
        guard let url = URL(string: "https://api.weatherapi.com/v1") else {
            preconditionFailure("WeatherAPIClient must have a valid baseURL.")
        }
        return url
    }

    private var authenticationQueryItem: URLQueryItem {
        return URLQueryItem(name: "key", value: Secrets.WeatherAPIKey)
    }

    private var airQualityIndexQueryItem: URLQueryItem {
        return URLQueryItem(name: "aqi", value: "yes")
    }
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getCurrentWeather(query: String) async throws -> CurrentWeather {
        var url = baseURL.appending(path: Endpoint.currentWeather.path)
        let queryItems: [URLQueryItem] = [
            authenticationQueryItem,
            URLQueryItem(name: "q", value: query),
            airQualityIndexQueryItem
        ]
        url = url.appending(queryItems: queryItems)
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        let responseModel = try decoder.decode(CurrentWeatherResponseModel.self, from: data)
        return responseModel.convertToCurrentWeather()
    }

    func searchLocations(query: String) async throws -> [Location] {
        var url = baseURL.appending(path: Endpoint.search.path)
        let queryItems: [URLQueryItem] = [
            authenticationQueryItem,
            URLQueryItem(name: "q", value: query),
        ]
        url = url.appending(queryItems: queryItems)
        let request = URLRequest(url: url)
        let (data, _) = try await session.data(for: request)
        let responseModel = try decoder.decode([LocationSearchResponseModel].self, from: data)
        return responseModel.map { $0.convertToLocation() }
    }
}

extension WeatherAPIClient {
    enum Endpoint {
        case currentWeather
        case forecast
        case search
        
        var path: String {
            return switch self {
            case .currentWeather: "/current.json"
            case .forecast: "/forecast.json"
            case .search: "/search.json"
            }
        }
    }
}
