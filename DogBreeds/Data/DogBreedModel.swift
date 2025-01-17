//
//  DogBreedModel.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import UIKit


struct Dog: Codable {
    let imageLink: String
    let goodWithChildren: Int
    let goodWithOtherDogs: Int
    let shedding: Int
    let grooming: Int
    let drooling: Int
    let coatLength: Int
    let goodWithStrangers: Int
    let playfulness: Int
    let protectiveness: Int
    let trainability: Int
    let energy: Int
    let barking: Int
    let minLifeExpectancy: Double
    let maxLifeExpectancy: Double
    let maxHeightMale: Double
    let maxHeightFemale: Double
    let maxWeightMale: Double
    let maxWeightFemale: Double
    let minHeightMale: Double
    let minHeightFemale: Double
    let minWeightMale: Double
    let minWeightFemale: Double
    let name: String
}
