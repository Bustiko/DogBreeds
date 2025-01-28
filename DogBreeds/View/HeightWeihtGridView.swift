//
//  HeightWeihtGridView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct HeightWeihtGridView: View {
    let breed: Dog
    var body: some View {
        Grid(horizontalSpacing: 30, verticalSpacing: 15) {
            GridRow {
                Color.clear
                    .gridCellUnsizedAxes([.horizontal, .vertical])
                Text("Height")
                    .modifier(DetailsGridTextModifier())
                Text("Weight")
                    .modifier(DetailsGridTextModifier())
            }// GRIDROW
            
            
            DetailsGridDataView(gender: .male, weightRange: (breed.minWeightMale, breed.maxWeightMale), heightRange: (breed.minHeightMale, breed.maxHeightMale))
                
            
            DetailsGridDataView(gender: .female, weightRange: (breed.minWeightFemale, breed.maxWeightFemale), heightRange: (breed.minHeightFemale, breed.maxHeightFemale))
            
        }// GRID
        .foregroundStyle(Color.beige)
        .modifier(DetailsGridViewModifier())
    }
}

#Preview {
    HeightWeihtGridView(breed: Dog(
        imageLink: "https://api-ninjas.com/images/dogs/shih_tzu.jpg", shedding: 1, grooming: 4, drooling: 1, coatLength: 1, playfulness: 3, protectiveness: 3, trainability: 4, energy: 3, barking: 3, maxHeightMale: 10.5, maxHeightFemale: 10.5, maxWeightMale: 16.0, maxWeightFemale: 16.0, minHeightMale: 9.0, minHeightFemale: 9.0, minWeightMale: 9.0, minWeightFemale: 9.0, name: "Shih Tzu"
    ))
}
