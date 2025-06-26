//
//  MainPageViewModel.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 26.06.2025.
//

import SwiftUI

class MainPageViewModel: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var isRandomPresented: Bool = false
    @Published var selectedRandomBreed: Dog? = nil
    @Published var isFavoritesShown: Bool = false
    
    let breedManager: BreedManager
    
    private var timer: Timer?
    private let numberOfTabs: Int = Constants.CarouselPhoto.allCases.count
    
    // MARK: - Initialization
    init(breedManager: BreedManager = BreedManager()) {
        self.breedManager = breedManager
    }
    
    // MARK: - Timer Handling
    func startScrolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 5.0)) {
                self.selectedTab = (self.selectedTab + 1) % self.numberOfTabs
            }
        }
    }
    
    func stopScrolling() {
        timer?.invalidate()
    }
    
    // MARK: - Helper Functions
    func toggleFavorites() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isFavoritesShown.toggle()
        }
    }
    
    func showRandomBreed() {
        if let randomBreed = breedManager.breedData.randomElement() {
                selectedRandomBreed = randomBreed
                isRandomPresented = true
        }
    }
    
    // MARK: - Data Management
    func fetchData() async {
        await breedManager.fetchData()
    }
}
