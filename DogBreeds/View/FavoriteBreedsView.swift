//
//  FavoriteBreedsView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct FavoriteBreedsView: View {
    let breedData: [Dog]
    let favoriteBreedNames: FetchedResults<Breed>
    var body: some View {
        ForEach(breedData, id: \.name) { breed in
            if favoriteBreedNames.contains(where: { $0.name == breed.name }) {
                NavigationLink {
                    DetailsPageView(breed: breed)
                } label: {
                    BreedGridItemView(imageURL: breed.imageLink, name: breed.name)
                }
            }
        }
    }
}
