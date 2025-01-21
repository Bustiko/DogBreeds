//
//  MainPageGridView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct MainPageGridView: View {
    @Binding var isFavoritesShown: Bool
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Breed.name, ascending: false)], animation: .default) private var favoriteBreedNames: FetchedResults<Breed>
    @ObservedObject var breedManager: BreedManager
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var groupedBreeds: [Character: [Dog]] {
        Dictionary(grouping: breedManager.breedData, by: { $0.name.first! })
    }
    
    var body: some View {
        ScrollView(.vertical) {
            if isFavoritesShown && favoriteBreedNames.isEmpty {
                EmptyFavoritesView()
            } else {
                LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                    if isFavoritesShown {
                        FavoriteBreedsView(breedData: breedManager.breedData, favoriteBreedNames: favoriteBreedNames)
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
        .shadow(radius: 5)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    MainPageGridView(isFavoritesShown: Binding(get: {false}, set: {_ in}), breedManager: BreedManager())
}
