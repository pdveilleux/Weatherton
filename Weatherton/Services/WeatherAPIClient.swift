//
//  WeatherAPIClient.swift
//  Weatherton
//
//  Created by Patrick Veilleux on 8/21/24.
//

import Foundation

final class WeatherAPIClient: WeatherService {
    private let session: URLSession
    private let uuidFactory: UUIDFactory

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

    init(session: URLSession = .shared, uuidFactory: UUIDFactory) {
        self.session = session
        self.uuidFactory = uuidFactory
    }

    func getCurrentWeather(location: Location) async throws -> CurrentWeather {
        let queryItems: [QueryParameter] = [
            .authentication,
            .location(location),
            .airQualityIndex(true)
        ]
        let url = createURL(endpoint: .currentWeather, queryParameters: queryItems)
        let responseModel = try await sendRequest(url: url, expecting: CurrentWeatherResponseModel.self)
        return responseModel.convertToCurrentWeather(id: uuidFactory.uuid())
    }

    func getForecast(location: Location) async throws -> Forecast {
        let queryItems: [QueryParameter] = [
            .authentication,
            .location(location),
            .forecastLength(7),
            .airQualityIndex(true)
        ]
        let url = createURL(endpoint: .forecast, queryParameters: queryItems)
        let responseModel = try await sendRequest(url: url, expecting: ForecastResponseModel.self)
        return responseModel.convertToForecast()
    }

    func searchLocations(query: String) async throws -> [Location] {
        let queryItems: [QueryParameter] = [
            .authentication,
            .search(query)
        ]
        let url = createURL(endpoint: .search, queryParameters: queryItems)
        let responseModel = try await sendRequest(url: url, expecting: [LocationSearchResponseModel].self)
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

    enum QueryParameter {
        case airQualityIndex(Bool)
        case authentication
        case forecastLength(Int)
        case location(Location)
        case search(String)

        var queryItem: URLQueryItem {
            return switch self {
            case .authentication:
                URLQueryItem(name: "key", value: Secrets.WeatherAPIKey)
            case .airQualityIndex(let include):
                URLQueryItem(name: "aqi", value: include ? "yes" : "no")
            case .location(let location):
                URLQueryItem(name: "q", value: "\(location.latitude),\(location.longitude)")
            case .forecastLength(let length):
                URLQueryItem(name: "days", value: String(length))
            case .search(let query):
                URLQueryItem(name: "q", value: query)
            }
        }
    }
}

extension WeatherAPIClient {
    private func createURL(endpoint: Endpoint, queryParameters: [QueryParameter]) -> URL {
        let url = baseURL.appending(path: endpoint.path)
        return url.appending(queryItems: queryParameters.map(\.queryItem))
    }

    private func sendRequest<Response>(url: URL, expecting type: Response.Type) async throws -> Response where Response: Decodable {
        try await sendRequest(URLRequest(url: url), expecting: type)
    }

    private func sendRequest<Response>(_ request: URLRequest, expecting type: Response.Type) async throws -> Response where Response: Decodable {
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: request)
        } catch URLError.notConnectedToInternet {
            throw WeatherServiceError.notConnectedToInternet
        } catch {
            throw WeatherServiceError.generic
        }
        
        guard let response = response as? HTTPURLResponse else {
            print("Error reading response")
            throw WeatherServiceError.generic
        }
        
        switch response.statusCode {
        case 200...299:
            return try decoder.decode(type, from: data)
        case 400...499:
            _ = try decoder.decode(ErrorResponseModel.self, from: data)
            throw WeatherServiceError.generic
        default:
            print("Non 2xx or 4xx error")
            throw WeatherServiceError.generic
        }
    }
}
