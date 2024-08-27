//
//  SavedPokemonsViewModel.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 27/08/2024.
//

import Foundation

@Observable
final class SavedPokemonsViewModel {
    private let pokemonStore: PokemonStore
    var savedPokemons = [Pokemon]()
    
    init(pokemonStore: PokemonStore) {
        self.pokemonStore = pokemonStore
    }
    
    func load() {
        pokemonStore.fetchPokemons()
        savedPokemons = pokemonStore.pokemons
    }
    
    func delete(at indexSet: IndexSet) {
        pokemonStore.delete(at: indexSet)
        load()
    }
}
