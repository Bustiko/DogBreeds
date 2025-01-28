//
//  NetworkError.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import UIKit

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case badStatus
    case JSONDecodeFail
}

