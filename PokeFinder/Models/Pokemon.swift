//
//  Pokemon.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import Foundation

/// Represents a Pokemon with it's info and images
struct Pokemon: Codable {
    let id: Int
    let order: Int
    let name: String
    let sprites: Sprites
}

struct Sprites: Codable {
    let backDefault: String
    let frontDefault: String
    let backShiny: String
    let frontShiny: String
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
    }
}
