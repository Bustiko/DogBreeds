//
//  DetailsPageView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import SwiftUI

struct DetailsPageView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isAddedToFavorites: Bool = false

    let breed: Dog
    
    private var traits: [(String, Int)] {
        [
         ("Barking", breed.barking),
         ("Grooming", breed.grooming),
         ("Playfulness", breed.playfulness),
         ("Protectiveness", breed.protectiveness),
         ("Trainability", breed.trainability),
         ("Shedding", breed.shedding),
         ("Energy", breed.energy)
        ]
    }
            
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                //MARK: - Header View
                Text("\(breed.name)")
                    .font(.system(.largeTitle, design: .rounded, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.beige)
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.clayBrown))
                    .padding(10)
                
                //MARK: - Photo View
                DogPhotoView(imageURL: breed.imageLink)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay {
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.clayBrown, lineWidth: 4)
                    }
                    .frame(height: 250)
                    .shadow(radius: 5)
                
                //MARK: - Height&Weight Grid View
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
                .padding(10)
                
                //MARK: - Details View
                Grid {
                    ForEach(traits, id: \.0) { trait in
                        if trait.1 != 0 {
                            GridRow {
                                Text(trait.0)
                                    .modifier(DetailsGridTextModifier())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                HStack {
                                    ForEach(0..<trait.1, id: \.self) { _ in
                                        Image(systemName: "pawprint.fill")
                                            .foregroundColor(.beige)
                                    }
                                    Spacer()
                                }// HSTACK
                            }// GRIDROW
                        }
                    }// FOREACH
                }// GRID
                .modifier(DetailsGridViewModifier())
                .padding(.horizontal, 10)
            }// VSTACK
        }// SCROLL
        .modifier(GradientBackground())
        .scrollIndicators(.hidden)
        .toolbarBackground(.beige.opacity(0.5), for: .navigationBar)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                DetailsPageToolbarItemView(imageName: "chevron.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                if isAddedToFavorites {
                    DetailsPageToolbarItemView(imageName: "heart.fill")
                        .onTapGesture {
                            isAddedToFavorites.toggle()
                        }
                }else {
                    DetailsPageToolbarItemView(imageName: "heart")
                        .onTapGesture {
                            isAddedToFavorites.toggle()
                        }
                }
                
            }
        }
    }
        
}

#Preview {
    NavigationStack {
        DetailsPageView(breed: Dog(
            imageLink: "https://api-ninjas.com/images/dogs/shih_tzu.jpg", shedding: 1, grooming: 4, drooling: 1, coatLength: 1, playfulness: 3, protectiveness: 3, trainability: 4, energy: 3, barking: 3, maxHeightMale: 10.5, maxHeightFemale: 10.5, maxWeightMale: 16.0, maxWeightFemale: 16.0, minHeightMale: 9.0, minHeightFemale: 9.0, minWeightMale: 9.0, minWeightFemale: 9.0, name: "Shih Tzu"
        ))
    }
   
}
