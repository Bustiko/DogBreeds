//
//  DetailsPageView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import SwiftUI
import FirebaseDatabase

struct DetailsPageView: View {
    @Environment(\.dismiss) var dismiss
    @State private var favoriteDogs: [Dog] = []
    var isFavorite: Bool {
        favoriteDogs.contains(where: { $0.name == breed.name })
    }
    
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
                HeightWeihtGridView(breed: breed)
                    .padding(10)
                
                //MARK: - Traits View
                TraitsGridView(traits: traits)
                    .padding(.horizontal, 10)
            }// VSTACK
        }// SCROLL
        .modifier(GradientBackground())
        .scrollIndicators(.hidden)
        .toolbarBackground(.beige.opacity(0.5), for: .navigationBar)
        .navigationBarBackButtonHidden()
        .accessibilityIdentifier("DetailsPageView")
        .onAppear {
            FirebaseManager.shared.fetchFavorites { dogs in
                favoriteDogs = dogs
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                DetailsPageToolbarItemView(imageName: "chevron.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                DetailsPageToolbarItemView(imageName: isFavorite ? "heart.fill" : "heart")
                    .onTapGesture {
                        if isFavorite {
                            FirebaseManager.shared.deleteFromFavorites(name: breed.name)
                            favoriteDogs.removeAll(where: { $0.name == breed.name })
                        } else {
                            FirebaseManager.shared.addToFavorites(dog: breed)
                            favoriteDogs.append(breed)
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
