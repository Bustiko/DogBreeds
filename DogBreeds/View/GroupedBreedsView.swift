//
//  GroupedBreedsView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct GroupedBreedsView: View {
    let groupedBreeds: [Character: [Dog]]
    
    var body: some View {
        ForEach(groupedBreeds.keys.sorted(), id: \.self) { letter in
            // Letter Header
            BreedGridItemView(imageURL: "", name: "\(letter)")
            
            // Breeds in this group
            ForEach(groupedBreeds[letter]!, id: \.name) { breed in
                NavigationLink {
                    DetailsPageView(breed: breed)
                } label: {
                    BreedGridItemView(imageURL: breed.imageLink, name: breed.name)
                }
            }
        }
    }
}
