//
//  BreedManager.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 17.01.2025.
//

import SwiftUI

@MainActor class BreedManager: ObservableObject{
    @Published var breedData: [Dog] = []
    private var isLoading: Bool = false
    private var isAllLoaded: Bool = false
    private let limit = 20
    private var page = 0
    
    func loadMore() async {
        await fetchData()
    }
    
    func fetchData() async {
        let offset = page * limit
        let url = "https://api.api-ninjas.com/v1/dogs?min_height=1&offset=\(offset)"
        let headers = ["X-Api-Key": "R7yoC5/BFnFCCVlYrknORQ==LWWnQlOGYUmWBFVA"]
        
        guard !isLoading && !isAllLoaded else {
            return
        }
        
        isLoading = true
        guard let data: [Dog] = await DataManager().fetchData(from: url, headers: headers) else {
            print("Error fetching breed data.")
            isLoading = false
            return
        }
        
        DispatchQueue.main.async {
            for dog in data {
                self.breedData.append(dog)
            }
            self.page += 1
            if data.count < self.limit {
                self.isAllLoaded = true
            }
        }
        
        isLoading = false
        
//        print(breedData)

    }
}
