//
//  FirebaseManager.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import FirebaseDatabase
import FirebaseAuth

class FirebaseManager {
    static let shared = FirebaseManager()

    let databaseRef: DatabaseReference
    var userId: String?

    private init() {
        self.databaseRef = Database.database().reference()
        restoreSessionOrAuthenticate()
    }

    // MARK: - Restore Session or Authenticate
    private func restoreSessionOrAuthenticate() {
        if let user = Auth.auth().currentUser {
            self.userId = user.uid
        } else {
            authenticateAnonymously()
        }
    }

    // MARK: - Authenticate Anonymously
    private func authenticateAnonymously() {
        Auth.auth().signInAnonymously { result, error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            if let user = result?.user {
                self.userId = user.uid
            }
        }
    }
    
    //MARK: - Add Favorite Breed
    func addToFavorites(dog: Dog) {
        guard let userId = userId else {
            print("User not authenticated")
            return
        }

        let dogDict = try? JSONEncoder().encode(dog)
        if let data = dogDict {
            let dogString = String(data: data, encoding: .utf8)
            databaseRef.child("favorites").child(userId).child(dog.name).setValue(dogString)
        }
    }

    
    //MARK: - Delete From Favorites
    func deleteFromFavorites(name: String) {
        guard let userId = userId else {
            print("User not authenticated")
            return
        }

        databaseRef.child("favorites").child(userId).child(name).removeValue { error, _ in
            if let error = error {
                print("Error deleting favorite: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - Fetch From Favorites
    func fetchFavorites(completion: @escaping ([Dog]) -> Void) {
        guard let userId = userId else {
            print("User not authenticated")
            completion([])
            return
        }

        databaseRef.child("favorites").child(userId).observeSingleEvent(of: .value) { snapshot in
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
