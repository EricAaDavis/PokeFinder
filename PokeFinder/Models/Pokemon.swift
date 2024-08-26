//
//  Pokemon.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import SwiftData
import Foundation

/// Represents a Pokemon with it's info and images
@Model
final class Pokemon: Decodable {
    var id: Int
    var order: Int
    var name: String
    var sprites: Sprites
    var dateAdded = Date()
    
    init(id: Int, order: Int, name: String, sprites: Sprites) {
        self.id = id
        self.order = order
        self.name = name
        self.sprites = sprites
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
        case sprites
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        order = try container.decode(Int.self, forKey: .order)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
    }
}

@Model
class Sprites: Decodable {
    var backDefault: String
    var frontDefault: String
    var backShiny: String
    var frontShiny: String
    
    init(backDefault: String, frontDefault: String, backShiny: String, frontShiny: String) {
        self.backDefault = backDefault
        self.frontDefault = frontDefault
        self.backShiny = backShiny
        self.frontShiny = frontShiny
    }
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frontDefault = try container.decode(String.self, forKey: .frontDefault)
        backDefault = try container.decode(String.self, forKey: .backDefault)
        frontShiny = try container.decode(String.self, forKey: .frontShiny)
        backShiny = try container.decode(String.self, forKey: .backShiny)
    }
}
