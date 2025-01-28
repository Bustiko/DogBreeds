//
//  HeaderView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct HeaderView: View {
    @Binding var isFavoritesShown: Bool
    let toggleFavorites: () -> Void
    let showRandomBreed: () -> Void
    
    var body: some View {
        HStack {
            // Title
            Text(isFavoritesShown ? "Favorite Breeds" : "Popular Breeds")
                .font(.title.bold())
                .foregroundColor(.clayBrown)
                .padding(5)
                .background(
                    Color.white.opacity(0.7)
                        .cornerRadius(16)
                        .padding(.horizontal, -20)
                )
                .padding(.horizontal)
            
            Spacer()
            
            // Favorites Button
            Button {
                toggleFavorites()
            } label: {
                MainPageHeaderButtonLabelView(imageName: isFavoritesShown ? "heart.fill" : "heart")
            }
            .scaleEffect(isFavoritesShown ? 1.2 : 1)
            .accessibilityIdentifier("FavoritesButton")
            
            // Random Breed Button
            Button {
                showRandomBreed()
            } label: {
                MainPageHeaderButtonLabelView(imageName: "wand.and.sparkles")
            }
            .accessibilityIdentifier("RandomBreedButton")
            
        }// HSTACK
        .padding()
        .background(Color.clayBrown.shadow(radius: 20))
        .foregroundStyle(Color.beige)
    }
}

#Preview {
    HeaderView(isFavoritesShown: Binding(get: {false}, set: {_ in}), toggleFavorites: {print("favorites")}, showRandomBreed:  {print("random")})
}
