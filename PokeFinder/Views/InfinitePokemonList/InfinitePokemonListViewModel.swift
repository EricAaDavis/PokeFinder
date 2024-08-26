//
//  ViewModel.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 26/08/2024.
//  Inspired by Eric Palma: https://www.curiousalgorithm.com/post/infinite-scrolling-using-swiftui-and-view-model-mvvm

import Foundation

@Observable
class InfinitePokemonListViewModel {
    // MARK: - Configuration
    private let pokemonsFromEndThreshold = 20
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
    var pokemonLocations: [PokemonLocation] = []
    var isLoading = false
    
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
        Task {
            do {
                let pokemonPaginationAPIService = PokemonPaginationAPIService(
                    limit: pokemonLocationsPerPage,
                    offset: pokemonLocationOffset
                )
                let response = try await pokemonPaginationAPIService.send()
                totalItemsAvailable = response.count
                // Use MainActor to force updates to the UI
                await MainActor.run {
                    pokemonLocations.append(contentsOf: response.pokemonLocations)
                    itemsLoadedCount = pokemonLocations.count
                }
            } catch {
                print("Failed to fetch next batch of pokemons")
            }
        }
    }
    
    // MARK: - Helpers
    
    private func isThresholdReached(_ pokemonsLoadedCount: Int, _ index: Int) -> Bool {
        (pokemonsLoadedCount - index) == pokemonsFromEndThreshold
    }
    
    private func moreItemsRemaining(_ pokemonsLoadedCount: Int, totalItemsAvailable: Int) -> Bool {
        pokemonsLoadedCount < totalItemsAvailable
    }
}
