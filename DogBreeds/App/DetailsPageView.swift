//
//  DetailsPageView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import SwiftUI
import CoreData

struct DetailsPageView: View {
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Breed.name, ascending: false)], animation: .default) private var favoriteBreedNames: FetchedResults<Breed>
    @Environment(\.dismiss) var dismiss
    
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
    
    //MARK: - Add Favorite Breed
    private func addToFavorites(name: String) {
        let favoriteBreed = Breed(context: context)
        favoriteBreed.name = name
        
        do {
            try context.save()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Delete From Favorites
    private func deleteFromFavorites(name: String) {
        let fetchRequest: NSFetchRequest<Breed> = Breed.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let breedNameToDelete = try context.fetch(fetchRequest)
            context.delete(breedNameToDelete[0])
            try context.save()
        }catch {
            print(error.localizedDescription)
        }
        
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                DetailsPageToolbarItemView(imageName: "chevron.left")
                    .onTapGesture {
                        dismiss()
                    }
            }
            ToolbarItem(placement: .topBarTrailing) {
                let isFavorite = favoriteBreedNames.contains(where: { $0.name == breed.name })
                DetailsPageToolbarItemView(imageName:  isFavorite ? "heart.fill" : "heart")
                    .onTapGesture {
                        
                        if isFavorite {
                            deleteFromFavorites(name: breed.name)
                        } else {
                            addToFavorites(name: breed.name)
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
