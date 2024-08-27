//
//  PokemonDetailView.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 27/08/2024.
//

import SwiftUI
import SwiftData

struct PokemonDetailView: View {
    let viewModel: PokemonDetailViewModel
    
    @State private var savePokemonButtonImageName = "bookmark"
    @State private var isShinyMode = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack {
                    if isShinyMode {
                        TabView {
                            ForEach(viewModel.pokemonImageURLsShiny, id: \.self) { imageUrl in
                                PokemonImageView(
                                    backgroundImageName: viewModel.pokemonBackgroundImageName,
                                    pokemonImageURL: imageUrl
                                )
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding()
                        }
                    } else {
                        TabView {
                            ForEach(viewModel.pokemonImageURLsDefault, id: \.self) { imageUrl in
                                PokemonImageView(
                                    backgroundImageName: viewModel.pokemonBackgroundImageName,
                                    pokemonImageURL: imageUrl
                                )
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 300)
                
                VStack(alignment: .leading) {
                    Toggle("Shiny Mode", isOn: $isShinyMode)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            setButtonAppearance()
        }
        .navigationTitle(viewModel.pokemonName)
        .toolbar {
            Button {
                handleStored()
            } label: {
                if viewModel.isPokemonStored {
                    Image(systemName: "bookmark.fill")
                } else {
                    Image(systemName: "bookmark")
                }
            }
        }
    }
    
    private func handleStored() {
        if !viewModel.isPokemonStored {
            viewModel.save()
        } else {
            viewModel.delete()
        }
        
        setButtonAppearance()
    }
    
    private func setButtonAppearance() {
        if viewModel.isPokemonStored {
            savePokemonButtonImageName = "bookmark.fill"
        } else {
            savePokemonButtonImageName = "bookmark"
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Pokemon.self, configurations: config)
    
    PokemonDetailView(viewModel: PokemonDetailViewModel(pokemon: Pokemon(
        id: 1,
        order: 1,
        name: "Bulbasaur",
        abilities: [
            Ability(
                abilityName: AbilityName(name: "Ability"),
                isHidden: false,
                slot: 1
            )
        ],
        sprites: Sprites(
            backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
            frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"), types: [
                PokemonType(slot: 1, pokemonTypeDetail: PokemonTypeDetail(pokemonTypeName: .ice, name: "hello"))                                                                       ]
    ), pokemonStore: PokemonStore(modelContext:  ModelContext(container))))
    .modelContainer(container)
}
