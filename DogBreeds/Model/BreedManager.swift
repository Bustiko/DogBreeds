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
    private var headers: [String:String] = [:]
    
    func loadMore() async {
        await fetchData()
    }
    
    func fetchData() async {
        let offset = page * limit
        
        let url = "https://api.api-ninjas.com/v1/dogs?min_height=1&offset=\(offset)"
        
        if let apiKey = ProcessInfo.processInfo.environment["API_KEY"] {
            print("API Key: " + apiKey)
            headers = ["X-Api-Key": apiKey]
        }else {
            print("API Key not found")
        }
        
        guard !isLoading && !isAllLoaded else {
            return
        }
        
        isLoading = true
        
        do {
            let data: [Dog]? = try await DataManager().fetchData(from: url, headers: headers)
            if let data = data {
                DispatchQueue.main.async {
                    
                    for dog in data {
                        self.breedData.append(dog)
                    }
                    self.page += 1
                    if data.count < self.limit {
                        self.isAllLoaded = true
                    }
                }
                
            }
        }catch NetworkError.invalidURL {
            print("Error creating URL object. Invalid URL string.")
            isLoading = false
            return
        }catch NetworkError.invalidResponse {
            print("Error. Got invalid response.")
            isLoading = false
            return
        }catch NetworkError.badStatus {
            print("Error. Bad response status.")
            isLoading = false
            return
        }catch NetworkError.JSONDecodeFail {
            print("Error decoding JSON into Swift object.")
            isLoading = false
            return
        }catch {
            print(error.localizedDescription)
            isLoading = false
            return
        }
        
        isLoading = false
        
    }
}
