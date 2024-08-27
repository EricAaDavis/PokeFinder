//
//  Results.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import Foundation

/// Represents a paginated response containing the total count and a list of Pokemon locations.
struct PokemonInfiniteScrollingResponse: Decodable {
    let count: Int
    let pokemonLocations: [PokemonLocation]
    
    enum CodingKeys: String, CodingKey {
        case count
        case pokemonLocations = "results"
    }
}

struct PokemonLocation: Decodable {
    let url: URL
}
