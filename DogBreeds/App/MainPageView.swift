//
//  MainPageView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import SwiftUI

struct MainPageView: View {
    @State private var selectedTab: Int = 0
    @State private var timer: Timer?
    @StateObject var breedManager: BreedManager = BreedManager()
    @State private var isRandomPresented: Bool = false
    @State private var selectedRandomBreed: Dog? = nil
    @State private var isFavoritesShown: Bool = false
    
    private let numberOfTabs: Int = Constants.CarouselPhoto.allCases.count
    
    // MARK: - Timer Handling
    private func startScrolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 5.0)) {
                selectedTab = (selectedTab + 1) % numberOfTabs
            }
        }
    }
    
    private func stopScrolling() {
        timer?.invalidate()
    }
    
    //MARK: - Helper Functions
    private func toggleFavorites() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isFavoritesShown.toggle()
        }
    }
    
    private func showRandomBreed() {
        if let randomBreed = breedManager.breedData.randomElement() {
            selectedRandomBreed = randomBreed
            isRandomPresented = true
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                //MARK: - Carousel View
                CarouselView(selectedTab: $selectedTab, numberOfTabs: numberOfTabs)
                    .onAppear {
                        startScrolling()
                    }
                    .onDisappear {
                        stopScrolling()
                    }
                
                //MARK: - Header View
                HeaderView(isFavoritesShown: $isFavoritesShown, toggleFavorites: toggleFavorites, showRandomBreed: showRandomBreed)
                
                //MARK: - Breed Grid
                MainPageGridView(isFavoritesShown: $isFavoritesShown, breedManager: breedManager)
                
            }// VSTACK
            .modifier(GradientBackground())
            .onAppear {
                Task {
                    await breedManager.fetchData()
                }
            }
            .navigationDestination(isPresented: $isRandomPresented) {
                if let breed = selectedRandomBreed {
                    DetailsPageView(breed: breed)
                }
            }
        }// NAVIGATION
        .accessibilityIdentifier("NavigationStack")
        
        
    }
}

#Preview {
    MainPageView(breedManager: BreedManager())
}
