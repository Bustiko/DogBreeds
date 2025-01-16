//
//  DataManager.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import UIKit

struct DataManager {
    func fetchData<T: Codable>(from url: String, headers: [String: String]? = nil) async -> T? {
        do {
            guard let url = URL(string: url) else {
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
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkError.JSONDecodeFail
            }
            
            return decodedResponse
            
        }catch NetworkError.invalidURL {
            print("Error creating URL object. Invalid URL string.")
        }catch NetworkError.invalidResponse {
            print("Error. Got invalid response.")
        }catch NetworkError.badStatus {
            print("Error. Bad response status.")
        }catch NetworkError.JSONDecodeFail {
            print("Error decoding JSON into Swift object.")
        }catch {
            print(error.localizedDescription)
        }
        
        return nil
        
    }
}

