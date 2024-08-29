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
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getCurrentWeather(query: String) async throws -> CurrentWeather {
        let queryItems: [QueryParameter] = [
            .authentication,
            .location(query),
            .airQualityIndex(true)
        ]
        let url = createURL(endpoint: .currentWeather, queryParameters: queryItems)
        let responseModel = try await sendRequest(url: url, expecting: CurrentWeatherResponseModel.self)
        return responseModel.convertToCurrentWeather()
    }

    func searchLocations(query: String) async throws -> [Location] {
        let queryItems: [QueryParameter] = [
            .authentication,
            .location(query)
        ]
        let url = createURL(endpoint: .search, queryParameters: queryItems)
        let responseModel = try await sendRequest(url: url, expecting: [LocationSearchResponseModel].self)
        return responseModel.map { $0.convertToLocation() }
    }

    func getForecast(query: String) async throws -> Forecast {
        let queryItems: [QueryParameter] = [
            .authentication,
            .location(query),
            .forecastLength(7),
            .airQualityIndex(true)
        ]
        let url = createURL(endpoint: .forecast, queryParameters: queryItems)
        let responseModel = try await sendRequest(url: url, expecting: ForecastResponseModel.self)
        return responseModel.convertToForecast()
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

    enum QueryParameter {
        case authentication
        case airQualityIndex(Bool)
        case location(String)
        case forecastLength(Int)

        var queryItem: URLQueryItem {
            return switch self {
            case .authentication:
                URLQueryItem(name: "key", value: Secrets.WeatherAPIKey)
            case .airQualityIndex(let include):
                URLQueryItem(name: "aqi", value: include ? "yes" : "no")
            case .location(let location):
                URLQueryItem(name: "q", value: location)
            case .forecastLength(let length):
                URLQueryItem(name: "days", value: String(length))
            }
        }
    }
}

extension WeatherAPIClient {
    private func createURL(endpoint: Endpoint, queryParameters: [QueryParameter]) -> URL {
        var url = baseURL.appending(path: endpoint.path)
        return url.appending(queryItems: queryParameters.map(\.queryItem))
    }

    private func sendRequest<Response>(_ request: URLRequest, expecting type: Response.Type) async throws -> Response where Response: Decodable {
        let (data, _) = try await session.data(for: request)
        return try decoder.decode(type, from: data)
    }

    private func sendRequest<Response>(url: URL, expecting type: Response.Type) async throws -> Response where Response: Decodable {
        try await sendRequest(URLRequest(url: url), expecting: type)
    }
}
