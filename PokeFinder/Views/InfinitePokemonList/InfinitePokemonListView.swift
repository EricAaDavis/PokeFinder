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
                let pokemonLocations = viewModel.pokemonLocations.enumerated().map({ $0 })
                if !pokemonLocations.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(pokemonLocations, id: \.element.id) { index, item in
                                Text(item.url?.absoluteString ?? "")
                                    .onAppear {
                                        viewModel.requestMoreItemsIfPossible(for: index)
                                        print(index)
                                    }
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    ContentUnavailableView("Unable to find pokemons", systemImage: "xmark.icloud", description: Text("Something went wrong when looking for all the pokemons😕"))
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
        }
    }
}

#Preview {
    InfinitePokemonListView(viewModel: InfinitePokemonListViewModel())
}
