//
//  DataManager.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import UIKit

protocol DataManagerProtocol {
    func fetchData<T: Codable>(from string: String, headers: [String: String]?) async throws -> T?
}

struct DataManager: DataManagerProtocol {
    func fetchData<T: Codable>(from string: String, headers: [String: String]? = nil) async throws -> T? {
            guard let url = URL(string: string) else {
                throw NetworkError.invalidURL
            }
            var request = URLRequest(url: url)
            
            if let headers = headers {
                for (key, value) in headers {
                    request.setValue(value, forHTTPHeaderField: key)
                }
            }
            
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                throw NetworkError.badStatus
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let decodedResponse = try? decoder.decode(T.self, from: data) else {
                throw NetworkError.JSONDecodeFail
            }
            
            return decodedResponse
        
    }
}

