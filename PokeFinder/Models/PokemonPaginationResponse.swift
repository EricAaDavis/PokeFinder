//
//  Results.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import Foundation

/// Represents a paginated response containing the total count and a list of Pokemon locations.
struct PokemonPaginationResponse: Codable {
    let count: Int
    let pokemonLocations: [PokemonLocation]
    
    enum CodingKeys: String, CodingKey {
        case count
        case pokemonLocations = "results"
    }
}

struct PokemonLocation: Codable {
    private let urlString: String
    
    var url: URL? {
        URL(string: urlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case urlString = "url"
    }
}
