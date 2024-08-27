import SwiftUI

struct InfinitePokemonListView: View {
    var viewModel: InfinitePokemonListViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                let pokemonLocations = viewModel.pokemons.enumerated().map({ $0 })
                if !pokemonLocations.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(pokemonLocations, id: \.element.id) { index, item in
                                PokemonCellView(viewModel: PokemonCellViewModel(pokemon: item))
                                    .onAppear {
                                        viewModel.requestMoreItemsIfPossible(for: index)
                                    }
                            }
                        }
                    }
                } else if let error = viewModel.error {
                    ContentUnavailableView(
                        "Unable to find pokemons",
                        systemImage: "xmark.icloud",
                        description: Text(error.localizedDescription)
                    )
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .task {
                viewModel.requestInitialSetOfPokemons()
            }
            .navigationTitle("Pokemons")
            .toolbar {
                if let error = viewModel.error {
                    if error == .fetchPokemonLocationsError {
                        Button {
                            viewModel.requestInitialSetOfPokemons()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    InfinitePokemonListView(viewModel: InfinitePokemonListViewModel())
}
