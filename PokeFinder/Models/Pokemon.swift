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
    var abilities: [Ability]
    var sprites: Sprites
    var types: [PokemonType]
    var dateAdded = Date()
    
    init(id: Int, order: Int, name: String, abilities: [Ability], sprites: Sprites, types: [PokemonType]) {
        self.id = id
        self.order = order
        self.name = name
        self.abilities = abilities
        self.sprites = sprites
        self.types = types
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case order
        case name
        case abilities
        case sprites
        case types
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        order = try container.decode(Int.self, forKey: .order)
        name = try container.decode(String.self, forKey: .name)
        abilities = try container.decode(Array<Ability>.self, forKey: .abilities)
        sprites = try container.decode(Sprites.self, forKey: .sprites)
        types = try container.decode(Array<PokemonType>.self, forKey: .types)
    }
}

@Model
final class Sprites: Decodable {
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

@Model
final class Ability: Decodable {
    var abilityName: AbilityName
    var isHidden: Bool
    var slot: Int
    
    init(abilityName: AbilityName, isHidden: Bool, slot: Int) {
        self.abilityName = abilityName
        self.isHidden = isHidden
        self.slot = slot
    }
    
    enum CodingKeys: String, CodingKey {
        case abilityName = "ability"
        case isHidden = "is_hidden"
        case slot
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        abilityName = try container.decode(AbilityName.self, forKey: .abilityName)
        isHidden = try container.decode(Bool.self, forKey: .isHidden)
        slot = try container.decode(Int.self, forKey: .slot)
    }
}

@Model
final class AbilityName: Decodable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
}

// MARK: - Pokemon Types

@Model
final class PokemonType: Decodable {
    var slot: Int
    var pokemonTypeDetail: PokemonTypeDetail
    
    init(slot: Int, pokemonTypeDetail: PokemonTypeDetail) {
        self.slot = slot
        self.pokemonTypeDetail = pokemonTypeDetail
    }
    
    enum CodingKeys: String, CodingKey {
        case slot
        case pokemonTypeDetail = "type"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        slot = try container.decode(Int.self, forKey: .slot)
        pokemonTypeDetail = try container.decode(PokemonTypeDetail.self, forKey: .pokemonTypeDetail)
    }
}

@Model
final class PokemonTypeDetail: Decodable {
    var pokemonTypeName: PokemonTypeName
    
    init(pokemonTypeName: PokemonTypeName) {
        self.pokemonTypeName = pokemonTypeName
    }
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeNameString = try container.decode(String.self, forKey: .name)
        pokemonTypeName = PokemonTypeName(rawValue: typeNameString) ?? .unknown
    }
}
