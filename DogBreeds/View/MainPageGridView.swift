//
//  MainPageGridView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct MainPageGridView: View {
    @Binding var isFavoritesShown: Bool
    @ObservedObject var breedManager: BreedManager
    @State private var favoriteDogs: [Dog] = []
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var groupedBreeds: [Character: [Dog]] {
        Dictionary(grouping: breedManager.breedData, by: { $0.name.first! })
    }
    
    var body: some View {
        ScrollView(.vertical) {
            if isFavoritesShown && favoriteDogs.isEmpty {
                EmptyFavoritesView()
            } else {
                LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                    if isFavoritesShown {
                        FavoriteBreedsView(favoriteDogs: favoriteDogs)
                    } else {
                        // Grouped Breeds
                        GroupedBreedsView(groupedBreeds: groupedBreeds)
                        
                        // Data Pagination
                        BreedGridItemView(imageURL: "", name: "Loading Data...")
                            .onAppear {
                                Task {
                                    await breedManager.loadMore()
                                }
                            }
                    }
                }
                .padding(16)
            }
        }
        .accessibilityIdentifier("Grid")
        .shadow(radius: 5)
        .scrollIndicators(.hidden)
        .onAppear {
            FirebaseManager.shared.fetchFavorites { dogs in
                favoriteDogs = dogs
            }
        }
    }
}

#Preview {
    MainPageGridView(isFavoritesShown: Binding(get: {false}, set: {_ in}), breedManager: BreedManager())
}
