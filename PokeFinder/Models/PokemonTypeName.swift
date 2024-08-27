//
//  PokemonTypeName.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 27/08/2024.
//

import Foundation

/// An enum type that represents a pokemon type name
enum PokemonTypeName: String, Codable {
    case normal, fire, water, electric, grass, ice, fighting, poison, ground, flying, psychic, bug, rock, ghost, dragon, dark, steel, fairy
    case unknown
    
    var emoji: String {
        switch self {
        case .normal: return "⭕️"
        case .fire: return "🔥"
        case .water: return "💧"
        case .electric: return "⚡️"
        case .grass: return "🌿"
        case .ice: return "❄️"
        case .fighting: return "🥊"
        case .poison: return "🧪"
        case .ground: return "🌍"
        case .flying: return "🕊️"
        case .psychic: return "🔮"
        case .bug: return "🐛"
        case .rock: return "🪨"
        case .ghost: return "👻"
        case .dragon: return "🐉"
        case .dark: return "🌑"
        case .steel: return "⚙️"
        case .fairy: return "🧚‍♂️"
        case .unknown: return "❓"
        }
    }
    
    var imageName: String {
        self.rawValue
    }
}
