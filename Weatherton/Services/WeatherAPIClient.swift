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
        let responseModel = try await sendRequest(request, expecting: CurrentWeatherResponseModel.self)
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
        let responseModel = try await sendRequest(request, expecting: [LocationSearchResponseModel].self)
        return responseModel.map { $0.convertToLocation() }
    }

    func getForecast(query: String) async throws -> Forecast {
        var url = baseURL.appending(path: Endpoint.forecast.path)
        let daysQueryItem = URLQueryItem(name: "days", value: "7")
        let queryItems: [URLQueryItem] = [
            authenticationQueryItem,
            URLQueryItem(name: "q", value: query),
            daysQueryItem,
            airQualityIndexQueryItem
        ]
        url = url.appending(queryItems: queryItems)
        let request = URLRequest(url: url)
        let responseModel = try await sendRequest(request, expecting: ForecastResponseModel.self)
        return responseModel.convertToForecast()
    }

    private func sendRequest<Response>(_ request: URLRequest, expecting type: Response.Type) async throws -> Response where Response: Decodable {
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(type, from: data)
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
