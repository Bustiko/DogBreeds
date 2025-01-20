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
    
    private let numberOfTabs: Int = Constants.CarouselPhoto.allCases.count
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    private var randomBreedNumber: Int {
        Int.random(in: 0..<breedManager.breedData.count)
    }
   
    // MARK: - Timer for Scrolling
    private func startScrolling() {
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 5.0)) {
                selectedTab = (selectedTab + 1) % numberOfTabs
            }
        }
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
                        Text("Popular Breeds")
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
                            
                        } label: {
                            MainPageHeaderButtonLabelView(imageName: "heart")
                        }

                        // Random Breed Button
                        Button {
                            isRandomPresented = true
                        } label: {
                            MainPageHeaderButtonLabelView(imageName: "wand.and.sparkles")
                        }
                        .fullScreenCover(isPresented: $isRandomPresented, content: {
                            NavigationStack {
                                DetailsPageView(breed: breedManager.breedData[randomBreedNumber])
                            }
                            
                        })
                    }// HSTACK
                    .padding()
                    .background(Color.clayBrown.shadow(radius: 20))
                    .foregroundStyle(Color.beige)
                    
                    
                //MARK: - Breed Grid
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                        ForEach(breedManager.breedData, id: \.name) { breed in
                            NavigationLink {
                                DetailsPageView(breed: breed)
                            } label: {
                                BreedGridView(imageURL: breed.imageLink, name: breed.name)
                                   
                            }
                        }// FOREACH
                    }// VGRID
                    .padding(16)
                }// SCROLL
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
}
