//
//  MockDataManager.swift
//  DogBreedsTests
//
//  Created by Buse Karabıyık on 22.01.2025.
//

import Foundation
@testable import DogBreeds

class MockDataManager: DataManagerProtocol {
    var fetchBreedsCalled = false
    
    func fetchData<T: Codable>(from string: String, headers: [String : String]?) async -> T? {
        fetchBreedsCalled = true
        
        guard let fileURL = Bundle(for: type(of: self)).url(forResource: string, withExtension: "json") else {
            print("Mock JSON file not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        }catch {
            print("Error decoding mock JSON: \(error.localizedDescription)")
            return nil
        }
        
    }
}
