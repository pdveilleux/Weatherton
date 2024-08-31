//
//  FakeURLProtocol.swift
//  WeathertonTests
//
//  Created by Patrick Veilleux on 8/30/24.
//

import Foundation

final class FakeURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        guard let handler = Self.requestHandler else {
            fatalError("Handler must be set before request is sent.")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            
            if let data = data {
                client?.urlProtocol(self, didLoad: data)
            }
            
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {}
}

extension FakeURLProtocol {
    enum Error: Swift.Error {
        case noURL
        case unableToMakeResponse
    }
}
