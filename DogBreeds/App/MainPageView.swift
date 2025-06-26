//
//  MainPageView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import SwiftUI

struct MainPageView: View {
    @StateObject private var viewModel = MainPageViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                //**MARK: - Carousel View**
                CarouselView(selectedTab: $viewModel.selectedTab, numberOfTabs: Constants.CarouselPhoto.allCases.count)
                    .onAppear {
                        viewModel.startScrolling()
                    }
                    .onDisappear {
                        viewModel.stopScrolling()
                    }
                
                //**MARK: - Header View**
                HeaderView(isFavoritesShown: $viewModel.isFavoritesShown, toggleFavorites: viewModel.toggleFavorites, showRandomBreed: viewModel.showRandomBreed)
                
                //**MARK: - Breed Grid**
                MainPageGridView(isFavoritesShown: $viewModel.isFavoritesShown, breedManager: viewModel.breedManager)
                
            }// VSTACK
            .modifier(GradientBackground())
            .onAppear {
                Task {
                    await viewModel.fetchData()
                }
            }
            .navigationDestination(isPresented: $viewModel.isRandomPresented) {
                if let breed = viewModel.selectedRandomBreed {
                    DetailsPageView(breed: breed)
                }
            }
        }// NAVIGATION
        .accessibilityIdentifier("NavigationStack")
    }
}

#Preview {
    MainPageView()
}
