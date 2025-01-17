//
//  BreedManager.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 17.01.2025.
//

import SwiftUI

class BreedManager: ObservableObject {
    @Published var breedData: [Dog] = []
    
    func fetchData() async {
        let url = "https://api.api-ninjas.com/v1/dogs?min_height=1"
        let headers = ["X-Api-Key": "R7yoC5/BFnFCCVlYrknORQ==LWWnQlOGYUmWBFVA"]
        
        guard let data: [Dog] = await DataManager().fetchData(from: url, headers: headers) else {
            print("Error fetching breed data.")
            return
        }
        
        breedData = data
        print(breedData)

    }
}
