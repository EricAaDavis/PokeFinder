//
//  PokemonCellView.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 26/08/2024.
//

import SwiftUI

struct PokemonCellView: View {
    let viewModel: PokemonCellViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: viewModel.pokemon.sprites.frontDefault)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
            }
            .frame(width: 150, height: 150)
            .padding()
            Text(viewModel.pokemon.name)
        }
    }
}

#Preview(traits: .fixedLayout(width: 150, height: 250)) {
    PokemonCellView(
        viewModel:PokemonCellViewModel(
            pokemon: Pokemon(
                id: 1,
                order: 1,
                name: "Pokemon with long name",
                sprites: Sprites(
                    backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
                    backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
                    frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png")
            )
        )
    )
}

#Preview(traits: .fixedLayout(width: 150, height: 250)) {
    PokemonCellView(
        viewModel:PokemonCellViewModel(
            pokemon: Pokemon(
                id: 1,
                order: 1,
                name: "Bulbasaur",
                sprites: Sprites(
                    backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                    backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                    frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
            )
        )
    )
}
