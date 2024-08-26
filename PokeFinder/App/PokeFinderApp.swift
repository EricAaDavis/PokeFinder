//
//  PokeFinder.swift
//  PokeFinder
//
//  Created by Eric Aagaard Davis on 24/08/2024.
//

import SwiftUI

@main
struct PokeFinderApp: App {
    var body: some Scene {
        WindowGroup {
            InfinitePokemonListView(viewModel: InfinitePokemonListViewModel())
        }
    }
}
