//
//  PokemonCellViewModel.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 26/08/2024.
//

import Foundation

@Observable
final class PokemonCellViewModel {
    private let pokemon: Pokemon
    let placeholderImageName = "photo"
        
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var pokemonName: String {
        pokemon.name.capitalized
    }
    
    var pokemonImageURL: URL? {
        URL(string: pokemon.sprites.frontDefault)
    }
    
    var backgroundImageName: String {
        let pokemonTypeName = pokemon.types.first { pokemonType in
            pokemonType.slot == 1
        }?.pokemonTypeDetail.pokemonTypeName ?? .unknown
        
        return pokemonTypeName.imageName
    }
    
    var pokemonTypeEmojis: [String] {
        pokemon.types.map { pokemonType in
            pokemonType.pokemonTypeDetail.pokemonTypeName.emoji
        }
    }
    
    var pokemonMainAbility: String {
        let mainAbility = pokemon.abilities.first { ability in
            ability.slot == 1
        }
        
        return mainAbility?.abilityName.name.capitalized ?? ""
    }
}
