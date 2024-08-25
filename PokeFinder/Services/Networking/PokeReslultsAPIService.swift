//
//  APIService.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import Foundation

/// Service to fetch a paginated list with URLs for a  specific Pokemon.
///
/// This service is designed for API requests that fetch a paginated list of URLs for a specific Pokemon.
/// It constructs the API request URL with pagination parameters (`limit` and `offset`) to fetch a specific range of results.
struct PokemonPaginationAPIService: APIRequest {
    
    typealias Response = PokemonPaginationResponse
    var providedURL: URL? = nil
    
    var limit: Int
    var offset: Int
    
    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
    }
    
    var path: String = "pokemon"
}
