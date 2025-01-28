//
//  FavoriteBreedsView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI
import FirebaseDatabase

struct FavoriteBreedsView: View {
    let favoriteDogs: [Dog]
    
    var body: some View {
        ForEach(favoriteDogs, id: \.name) { breed in
            NavigationLink {
                DetailsPageView(breed: breed)
            } label: {
                BreedGridItemView(imageURL: breed.imageLink, name: breed.name)
            }
        }
        
    }
}
