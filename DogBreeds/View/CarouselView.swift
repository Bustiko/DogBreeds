//
//  CarouselView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct CarouselView: View {
    @Binding var selectedTab: Int
    let numberOfTabs: Int
    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(0..<numberOfTabs, id: \.self) { index in
                let photo = Constants.CarouselPhoto.allCases[index]
                Image(photo.rawValue)
                    .resizable()
                    .scaledToFill()
                    .shadow(radius: 10)
                    .frame(height: 200, alignment: .center)
                    .tag(index)
                    .accessibilityIdentifier("CarouselImage-\(index)")
            }// FOREACH
        }// TABVIEW
        .background(Color.clayBrown)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 200)
        .accessibilityIdentifier("CarouselView")
    }
}

#Preview {
    CarouselView(selectedTab: Binding(get: {2}, set: { _ in}), numberOfTabs: 4)
}
