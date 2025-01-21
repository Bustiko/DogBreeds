//
//  MainPageView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import SwiftUI
import CoreData

struct MainPageView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Breed.name, ascending: false)], animation: .default) private var favoriteBreedNames: FetchedResults<Breed>
    @State private var selectedTab: Int = 0
    @State private var timer: Timer?
    @StateObject var breedManager: BreedManager = BreedManager()
    @State private var isRandomPresented: Bool = false
    @State private var selectedRandomBreed: Dog? = nil
    @State private var isFavoritesShown: Bool = false
    
    private let numberOfTabs: Int = Constants.CarouselPhoto.allCases.count
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var groupedBreeds: [Character: [Dog]] {
        Dictionary(grouping: breedManager.breedData, by: { $0.name.first! })
    }
   
    
    // MARK: - Timer for Scrolling
    private func startScrolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 5.0)) {
                selectedTab = (selectedTab + 1) % numberOfTabs
            }
        }
    }
    
    private func chooseRandom() -> Int {
        Int.random(in: 0..<breedManager.breedData.count)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                //MARK: - Carousel View
                TabView(selection: $selectedTab) {
                    ForEach(0..<numberOfTabs, id: \.self) { index in
                        let photo = Constants.CarouselPhoto.allCases[index]
                        Image(photo.rawValue)
                            .resizable()
                            .scaledToFill()
                            .shadow(radius: 10)
                            .frame(height: 200, alignment: .center)
                            .tag(index)
                    }// FOREACH
                }// TABVIEW
                .background(Color.clayBrown)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 200)
                .onAppear {
                    startScrolling()
                }
                .onDisappear {
                    timer?.invalidate()
                }
                
                //MARK: - Header View
                HStack {
                    // Title
                    Text(isFavoritesShown ? "Favorite Breeds" : "Popular Breeds")
                        .font(.title.bold())
                        .foregroundColor(.clayBrown)
                        .padding(5)
                        .background(
                            Color.white.opacity(0.7)
                                .cornerRadius(16)
                                .padding(.horizontal, -20)
                        )
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // Favorites Button
                    Button {
                        Task {
                            await breedManager.fetchData()
                        }
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isFavoritesShown.toggle()
                        }
                        
                    } label: {
                        if isFavoritesShown {
                            MainPageHeaderButtonLabelView(imageName: "heart.fill")
                        }else {
                            MainPageHeaderButtonLabelView(imageName: "heart")
                        }
                        
                    }
                    .scaleEffect(isFavoritesShown ? 1.2 : 1)
                    
                    // Random Breed Button
                    Button {
                        if let randomBreed = breedManager.breedData.randomElement() {
                            selectedRandomBreed = randomBreed
                            isRandomPresented = true
                        }
                    } label: {
                        MainPageHeaderButtonLabelView(imageName: "wand.and.sparkles")
                    }
                    .navigationDestination(isPresented: $isRandomPresented) {
                        if let breed = selectedRandomBreed {
                            DetailsPageView(breed: breed)
                        }
                    }
                }// HSTACK
                .padding()
                .background(Color.clayBrown.shadow(radius: 20))
                .foregroundStyle(Color.beige)
                
                
                //MARK: - Breed Grid
                ScrollView(.vertical) {
                    if isFavoritesShown && favoriteBreedNames.isEmpty {
                        HStack {
                            Image(systemName: "pawprint")
                                .font(.system(size: 50, weight: .bold))
                                .foregroundColor(.clayBrown)
                            Text("Add breeds to your favorites list to see them here!")
                                .font(.headline)
                                .foregroundColor(.clayBrown)
                        }
                    } else {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                            if isFavoritesShown {
                                ForEach(breedManager.breedData, id: \.name) { breed in
                                    if favoriteBreedNames.contains(where: { $0.name == breed.name }) {
                                        NavigationLink {
                                            DetailsPageView(breed: breed)
                                        } label: {
                                            BreedGridView(imageURL: breed.imageLink, name: breed.name)
                                        }
                                    }
                                    
                                }
                            } else {
                                // Grouped Breeds
                                ForEach(groupedBreeds.keys.sorted(), id: \.self) { letter in
                                    // Letter Header
                                    BreedGridView(imageURL: "", name: "\(letter)")
                                    
                                    // Breeds in this group
                                    ForEach(groupedBreeds[letter]!, id: \.name) { breed in
                                        NavigationLink {
                                            DetailsPageView(breed: breed)
                                        } label: {
                                            BreedGridView(imageURL: breed.imageLink, name: breed.name)
                                        }
                                    }
                                }
                                
                                // Data Pagination
                                BreedGridView(imageURL: "", name: "Loading Data...")
                                    .onAppear {
                                        Task {
                                            await breedManager.loadMore()
                                        }
                                    }
                            }
                        }
                        .padding(16)
                    }
                } // ScrollView
                .shadow(radius: 5)
                .scrollIndicators(.hidden)

                
            }// VSTACK
            .modifier(GradientBackground())
            .onAppear {
                Task {
                    await breedManager.fetchData()
                }
            }
        }// NAVIGATION
        
    }
}

#Preview {
    MainPageView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
