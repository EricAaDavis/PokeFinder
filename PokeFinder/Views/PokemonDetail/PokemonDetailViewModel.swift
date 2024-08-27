//
//  PokemonDetailViewModel.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 27/08/2024.
//

import Foundation
import SwiftData

@Observable
final class PokemonDetailViewModel {
    private let id: Int
    private let name: String
    private let types: [PokemonType]
    private let sprites: Sprites
    
    private var pokemon: Pokemon
    private var pokemonStore: PokemonStore
    
    init(pokemon: Pokemon, pokemonStore: PokemonStore) {
        self.pokemon = pokemon
        self.id = pokemon.id
        self.name = pokemon.name
        self.types = pokemon.types
        self.sprites = pokemon.sprites
        self.pokemonStore = pokemonStore
    }
    
    var pokemonName: String {
        name.capitalized
    }
    
    var pokemonBackgroundImageName: String {
        let pokemonType = types.first { pokemon in
            pokemon.slot == 1
        }?.pokemonTypeDetail.pokemonTypeName ?? .unknown
        
        return pokemonType.rawValue
    }
    
    var pokemonImageURLsDefault: [URL?] {
        [
            URL(string: sprites.frontDefault),
            URL(string: sprites.backDefault)
        ]
    }
    
    var pokemonImageURLsShiny: [URL?] {
        [
            URL(string: sprites.frontShiny),
            URL(string: sprites.backShiny)
        ]
    }
    
    // MARK: - Persistence
    
    var isPokemonStored: Bool {
        pokemonStore.checkIfPokemonIsStored(id: id)
    }
    
    func update() {
        pokemonStore.fetchPokemons()
    }
    
    func save() {
        pokemonStore.save(pokemon)
    }
    
    func delete() {
        pokemonStore.delete(id: pokemon.id)
    }
}
