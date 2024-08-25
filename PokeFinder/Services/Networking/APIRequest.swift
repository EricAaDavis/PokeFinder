//
//  APIRequest.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import Foundation

protocol APIRequest {
    associatedtype Response
    
    /// An optional URL that can be used if the API returns a URL for a Pokemon.
    var providedURL: URL? { get }
}

extension APIRequest {
    var host: String { "pokeapi.co" }
    var path: String { "/api/v2/pokemon" }
    var queryItems: [URLQueryItem]? { nil }
}

extension APIRequest {
    /// Composes the URL if providedURL is nil
    var request: URLRequest {
        if let providedURL {
            return URLRequest(url: providedURL)
        } else {
            var components = URLComponents()
            components.scheme = "https"
            components.host = host
            components.path = path
            components.queryItems = queryItems
            
            // Safe to force unwrap as we have all the components in the URL, hence a valid URL
            let request = URLRequest(url: components.url!)
            
            return request
        }
    }
}

enum APIRequestError: Error {
    case itemsNotFound
    case requestFailed
    case decodingFailed
    case invalidStatusCode(Int)
}

// Isolates the extension method to types that conform to Decodable.
extension APIRequest where Response: Decodable {
    func send() async throws -> Response {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIRequestError.itemsNotFound
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIRequestError.invalidStatusCode(httpResponse.statusCode)
        }
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw APIRequestError.decodingFailed
        }
    }
}
