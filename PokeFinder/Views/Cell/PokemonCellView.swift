//
//  PokemonCellView.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 26/08/2024.
//

import SwiftUI

struct PokemonCellView: View {
    let viewModel: PokemonCellViewModel
    
    // MARK: Constants
    
    let idealCellHeight = 200.0
    let cellPadding = 8.0
    let textViewSpacing = 6.0
    let backgroundCornerRadius = 12.0
    let placeholderImageOpacity = 0.75
    
    var body: some View {
        VStack(alignment: .leading) {
            PokemonImageView(
                backgroundImageName: viewModel.backgroundImageName,
                pokemonImageURL: viewModel.pokemonImageURL
            )
            .frame(maxWidth: .infinity, idealHeight: idealCellHeight)
            .cornerRadius(backgroundCornerRadius)
            
            VStack(alignment: .leading, spacing: textViewSpacing) {
                Text(viewModel.pokemonName)
                    .lineLimit(.zero)
                    .font(.headline)
                Text(viewModel.pokemonMainAbility)
                    .lineLimit(.zero)
                    .font(.caption2)
                HStack {
                    ForEach(viewModel.pokemonTypeEmojis, id: \.self) { pokemonTypeEmoji in
                        Text(pokemonTypeEmoji)
                    }
                }
            }
        }
        .padding(cellPadding)
        .accessibilityElement(children: .combine)
    }
}

#Preview(traits: .fixedLayout(width: 150, height: 300)) {
    PokemonCellView(
        viewModel:PokemonCellViewModel(
            pokemon: Pokemon(
                id: 1,
                order: 1,
                name: "Pokemon with long name",
                abilities: [
                    Ability(
                        abilityName: AbilityName(name: "Ability"),
                        isHidden: false,
                        slot: 1
                    )
                ],
                sprites: Sprites(
                    backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
                    backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png",
                    frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/2.png"), types: [PokemonType(slot: 1, pokemonTypeDetail: PokemonTypeDetail(pokemonTypeName: .fire, name: "hello"))]
            )
        )
    )
}

#Preview(traits: .fixedLayout(width: 150, height: 300)) {
    PokemonCellView(
        viewModel:PokemonCellViewModel(
            pokemon: Pokemon(
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
            )
        )
    )
}
