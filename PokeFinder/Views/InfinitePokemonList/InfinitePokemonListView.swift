import SwiftUI

struct InfinitePokemonListView: View {
    @Environment(\.modelContext) var modelContext
    
    var viewModel: InfinitePokemonListViewModel
    
    @State var isPresented = false
    
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
                                NavigationLink {
                                    PokemonDetailView(
                                        viewModel: PokemonDetailViewModel(
                                            pokemon: item,
                                            pokemonStore: PokemonStore(modelContext: modelContext)
                                        )
                                    )
                                } label: {
                                    PokemonCellView(viewModel: PokemonCellViewModel(pokemon: item))
                                        .onAppear {
                                            viewModel.requestMoreItemsIfPossible(for: index)
                                        }
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
            .sheet(isPresented: $isPresented) {
                SavedPokemonsView(
                    viewModel: SavedPokemonsViewModel(
                        pokemonStore: PokemonStore(
                            modelContext: modelContext
                        )
                    )
                )
                .presentationDetents([.medium, .large])
            }
            .navigationTitle("Pokemons")
            .toolbar {
                HStack {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                    
                    
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
}

//#Preview {
//    InfinitePokemonListView(viewModel: InfinitePokemonListViewModel())
//}
