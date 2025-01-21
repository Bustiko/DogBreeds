//
//  FirebaseManager.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import FirebaseDatabase

class FirebaseManager {
    static let shared = FirebaseManager()
    
    let databaseRef: DatabaseReference
    
    private init() {
        self.databaseRef = Database.database().reference()
    }
    
    //MARK: - Add Favorite Breed
    func addToFavorites(dog: Dog) {
        let dogDict = try? JSONEncoder().encode(dog)
        if let data = dogDict {
            let dogString = String(data: data, encoding: .utf8)
            FirebaseManager.shared.databaseRef.child("favorites").child(dog.name).setValue(dogString)
        }
    }

    
    //MARK: - Delete From Favorites
    func deleteFromFavorites(name: String) {
        FirebaseManager.shared.databaseRef.child("favorites").child(name).removeValue { error, _ in
            if let error = error {
                print("Error deleting favorite: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Fetch From Favorites
    func fetchFavorites(completion: @escaping ([Dog]) -> Void) {
        databaseRef.child("favorites").observeSingleEvent(of: .value) { snapshot, error in //snapshot is the current node
            if let error = error {
                print(error)
            }
            
            guard let pairs = snapshot.value as? [String: String], !pairs.isEmpty else {
                completion([])
                return
            }

            let dogs = pairs.compactMap { _, dogString in //_, dogString -> key, value
                try? JSONDecoder().decode(Dog.self, from: Data(dogString.utf8))
            }
            
            completion(dogs)
        }
    }


}
