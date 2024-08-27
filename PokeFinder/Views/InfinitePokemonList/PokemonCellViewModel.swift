//
//  PokemonCellViewModel.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 26/08/2024.
//

import Foundation

@Observable
final class PokemonCellViewModel {
    var pokemon: Pokemon
    var isLoading = true
        
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}
