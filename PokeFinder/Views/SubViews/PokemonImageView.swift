//
//  PokemonImageView.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 27/08/2024.
//

import SwiftUI

struct PokemonImageView: View {
    let backgroundImageName: String
    let pokemonImageURL: URL?
    
    let placeholderImageOpacity = 0.75
    
    var body: some View {
        ZStack() {
            Image(backgroundImageName)
                .resizable()
            
            Rectangle()
                .fill(.ultraThinMaterial)
            
            VStack {
                AsyncImage(url: pokemonImageURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    PokemonImageView(backgroundImageName: "water", pokemonImageURL: nil)
}
