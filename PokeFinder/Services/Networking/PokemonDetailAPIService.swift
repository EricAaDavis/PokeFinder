//
//  PokeAPIService.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import Foundation

/// Service to fetch details of a specific Pokemon.
///
/// This service is responsible for making an API request to retrieve detailed information about a single Pokemon.
/// The URL must be provided during initialization, ensuring the service is used only with a specific URL.
/// Use this service when you need to fetch data for a pokemon using the URL provided from the .
struct PokemonDetailAPIService: APIRequest {
    typealias Response = Pokemon
    
    init(providedURL: URL) {
        self.providedURL = providedURL
    }
    
    var providedURL: URL?
}
