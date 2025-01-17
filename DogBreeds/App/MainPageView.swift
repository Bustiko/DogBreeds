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
    private let numberOfTabs: Int = Constants.CarouselPhoto.allCases.count
    private let columns = Array(repeating: GridItem(.flexible()), count: 3)
   
  
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
                TabView(selection: $selectedTab) {
                    ForEach(0..<numberOfTabs, id: \.self) { index in
                        let photo = Constants.CarouselPhoto.allCases[index]
                        Image(photo.rawValue)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200, alignment: .center)
                            .tag(index)
                    }
                }
                .background(Color.clayBrown)
                .shadow(radius: 5)
                .onAppear {
                    startScrolling()
                    Task {
                       await breedManager.fetchData()
                        
                    }
                   
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 200)
                
              
                
                    HStack {
                        Text("Popular Breeds")
                            .font(.system(.title, design: .rounded, weight: .black))
                           
                        
                        Spacer()
                        
                        Image(systemName: "heart.circle")
                            .font(.title)
                        
                        Image(systemName: "wand.and.sparkles")
                            .font(.title2)
                            .fontWeight(.black)
                    }
                    .padding()
                    .background(Color.clayBrown)
                    .foregroundStyle(Color.beige)
                    .shadow(radius: 5)
                    
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, alignment: .center, spacing: 1) {
                        ForEach(breedManager.breedData, id: \.name) { breed in
                            NavigationLink {
                                DetailsPageView()
                            } label: {
                                BreedGridView(imageURL: breed.imageLink, name: breed.name)
                            }
                            
                        }
                    }
                }
                .padding()
                .scrollIndicators(.hidden)
                .shadow(radius: 5)
       
            }
            .background(
                Image("backgroundphoto")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            
        }
        
        
    }
}


#Preview {
    MainPageView()
}
