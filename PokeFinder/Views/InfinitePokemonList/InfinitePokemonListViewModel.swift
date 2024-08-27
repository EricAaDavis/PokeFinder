//
//  ViewModel.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 26/08/2024.
//  Inspired by Eric Palma: https://www.curiousalgorithm.com/post/infinite-scrolling-using-swiftui-and-view-model-mvvm

import Foundation
import SwiftData

@Observable
final class InfinitePokemonListViewModel {
    // MARK: - Configuration
    private let pokemonsFromEndThreshold = 10
    private let pokemonLocationsPerPage = 30
    
    /// The first pokemon in the next page to fetch.
    private var pokemonLocationOffset: Int {
        pokemonLocationsPerPage * page
    }
    
    // MARK: - API Pagination data
    private var totalItemsAvailable: Int?
    private var itemsLoadedCount: Int?
    private var page = 0
    
    // MARK: - Pokemons
    private var pokemonLocations = [PokemonLocation]()
    var pokemons = [Pokemon]()
    var isLoading = false
    var error: InfinitePokemonListError?
    
    // MARK: - Actions
    
    func requestInitialSetOfPokemons() {
        requestPokemonLocations(for: page)
    }
    
    func requestMoreItemsIfPossible(for index: Int) {
        guard let itemsLoadedCount,
              let totalItemsAvailable else {
            
            return
        }
        
        if isThresholdReached(itemsLoadedCount, index) && moreItemsRemaining(itemsLoadedCount, totalItemsAvailable: totalItemsAvailable) {
            // Request next page
            requestPokemonLocations(for: page)
            page += 1
        }
    }
    
    private func requestPokemonLocations(for page: Int) {
        error = nil
        isLoading = true
        
        Task {
            do {
                let pokemonPaginationAPIService = PokemonPaginationService(
                    limit: pokemonLocationsPerPage,
                    offset: pokemonLocationOffset
                )
                let pokemonInfiniteScrollingResponse = try await pokemonPaginationAPIService.send()
                totalItemsAvailable = pokemonInfiniteScrollingResponse.count
                pokemonLocations.append(contentsOf: pokemonInfiniteScrollingResponse.pokemonLocations)
                itemsLoadedCount = pokemonLocations.count
                requestPokemonDetails(locations: pokemonInfiniteScrollingResponse.pokemonLocations)
            } catch {
                self.error = InfinitePokemonListError.fetchPokemonLocationsError
                isLoading = false
            }
        }
    }
    
    private func requestPokemonDetails(locations: [PokemonLocation]) {
        error = nil
        var fetchedPokemons = [Pokemon]()
        
        Task {
            do {
                try await withThrowingTaskGroup(of: Pokemon?.self) { group in
                    for location in locations {
                        group.addTask {
                            let pokemonDetailAPIService = PokemonDetailService(providedURL: location.url)
                            return try await pokemonDetailAPIService.send()
                        }
                    }
                    
                    for try await pokemon in group {
                        if let pokemon = pokemon {
                            fetchedPokemons.append(pokemon)
                        }
                    }
                    
                    fetchedPokemons.sort(by: { $0.order < $1.order })
                    pokemons.append(contentsOf: fetchedPokemons)
                    await MainActor.run {
                        isLoading = false
                    }
                }
            } catch {
                self.error = InfinitePokemonListError.fetchPokemonDetailsError
                await MainActor.run {
                    isLoading = false
                }
            }
        }
    }
    
    // MARK: - Validation
    
    private func isThresholdReached(_ pokemonsLoadedCount: Int, _ index: Int) -> Bool {
        (pokemonsLoadedCount - index) == pokemonsFromEndThreshold
    }
    
    private func moreItemsRemaining(_ pokemonsLoadedCount: Int, totalItemsAvailable: Int) -> Bool {
        pokemonsLoadedCount < totalItemsAvailable
    }
}

enum InfinitePokemonListError: Error {
    case fetchPokemonLocationsError
    case fetchPokemonDetailsError
}
