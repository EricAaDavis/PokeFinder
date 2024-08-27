//
//  SavedPokemonsView.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 27/08/2024.
//

import SwiftUI
import SwiftData

struct SavedPokemonsView: View {
    let viewModel: SavedPokemonsViewModel
    
    var body: some View {
        NavigationStack {
            if viewModel.savedPokemons.isEmpty {
                ContentUnavailableView("No pokemons saved", systemImage: "xmark.circle", description: Text("Mark a pokemon as a favorite to save it")
                )
            } else {
                List {
                    ForEach(viewModel.savedPokemons) { pokemon in
                        NavigationLink {
                            Text(pokemon.name)
                        } label: {
                            Text(pokemon.name)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.delete(at: indexSet)
                    }
                }
            }
        }
        .onAppear {
            viewModel.load()
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Pokemon.self, configurations: config)
    SavedPokemonsView(viewModel: SavedPokemonsViewModel(pokemonStore: PokemonStore(modelContext:  ModelContext(container))))
        .modelContainer(container)
}

