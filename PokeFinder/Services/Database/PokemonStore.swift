//
//  PokemonStore.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 25/08/2024.
//

import Foundation
import SwiftData

@Observable
final class PokemonStore {
    private(set) var pokemons = [Pokemon]()
    private(set) var pokemonStoreError: PokemonStoreError?
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchPokemons()
    }
    
    // MARK: - Fetch
    
    /// Fetches all Pokemon from the persistent store and sorts them by date added.
    func fetchPokemons() {
        let fetchRequest = FetchDescriptor<Pokemon>(sortBy: [SortDescriptor(\.dateAdded)])
        do {
            pokemons = try modelContext.fetch(fetchRequest).reversed()
        } catch {
            pokemonStoreError = .fetchError(description: "Sorry, we were unable to find your saved pokemons😭")
        }
    }
    
    // MARK: - Actions
    
    /// Saves a Pokemon to the persistent store.
    func save(_ pokemon: Pokemon) {
        do {
            if !checkIfPokemonIsStored(pokemon) {
                modelContext.insert(pokemon)
                try modelContext.save()
                fetchPokemons()
            } else {
                pokemonStoreError = .duplicateError(pokemonName: pokemon.name)
            }
        } catch {
            pokemonStoreError = .saveError(description: "Sorry, we could not save this pokemon😢")
        }
    }
    
    /// Deletes a Pokemon from the persistent store at a specified index.
    ///
    /// Used when deleting a Pokemon in a List .
    func delete(at indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(pokemons[index])
        }
        
        do {
            try modelContext.save()
            fetchPokemons()
        } catch {
            pokemonStoreError = .deleteError(description: "Sorry, we could not delete your saved pokemon😿")
        }
    }
    
    func delete(id: Int) {
        do {
            try modelContext.delete(model: Pokemon.self, where: #Predicate {
                id == $0.id
            })
            fetchPokemons()
        } catch {
            pokemonStoreError = .deleteError(description: "Sorry, we could not delete this pokemon😢")

        }
    }
    
    /// Deletes a specified Pokemon from the persistent store.
    func delete(_ pokemon: Pokemon) {
        modelContext.delete(pokemon)
        do {
            try modelContext.save()
            fetchPokemons()
        } catch {
            pokemonStoreError = .deleteError(description: "Sorry, we could not un-favor your Pokemon😕")
        }
    }
    
    // MARK: - Validation
    
    /// Checks if a Pokemon is already stored in the persistent store.
    ///
    /// - Returns: `true` if the Pokemon is stored, `false` otherwise.
    func checkIfPokemonIsStored(_ pokemon: Pokemon) -> Bool {
        checkIfPokemonIsStored(id: pokemon.id)
    }
    
    func checkIfPokemonIsStored(id: Int) -> Bool {
        pokemons.contains { currentPokemon in
            currentPokemon.id == id
        }
    }
}

enum PokemonStoreError: Error {
    case fetchError(description: String)
    case saveError(description: String)
    case deleteError(description: String)
    case duplicateError(pokemonName: String)
    
    var localizedDescription: String {
        switch self {
        case .fetchError(let description),
             .saveError(let description),
             .deleteError(let description):
            
            return description
        case .duplicateError(let pokemonName):
            return "Oops, \(pokemonName) is already saved🤔"
        }
    }
}
