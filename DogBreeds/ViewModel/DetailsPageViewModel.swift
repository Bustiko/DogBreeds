//
//  DetailsPageViewModel.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 26.06.2025.
//

import SwiftUI
import FirebaseDatabase

class DetailsPageViewModel: ObservableObject {
    @Published var favoriteDogs: [Dog] = []
    
    let breed: Dog
    private let firebaseManager: FirebaseManager
    
    // MARK: - Computed Properties
    var isFavorite: Bool {
        favoriteDogs.contains(where: { $0.name == breed.name })
    }
    
    var traits: [(String, Int)] {
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
    
    // MARK: - Initialization
    init(breed: Dog, firebaseManager: FirebaseManager = FirebaseManager.shared) {
        self.breed = breed
        self.firebaseManager = firebaseManager
    }
    
    // MARK: - Data Management
    func fetchFavorites() {
        firebaseManager.fetchFavorites { dogs in
            self.favoriteDogs = dogs
        }
    }
    
    // MARK: - Favorite Actions
    func toggleFavorite() {
        if isFavorite {
            removeFromFavorites()
        } else {
            addToFavorites()
        }
    }
    
    private func addToFavorites() {
        firebaseManager.addToFavorites(dog: breed)
        favoriteDogs.append(breed)
    }
    
    private func removeFromFavorites() {
        firebaseManager.deleteFromFavorites(name: breed.name)
        favoriteDogs.removeAll(where: { $0.name == breed.name })
    }
}
