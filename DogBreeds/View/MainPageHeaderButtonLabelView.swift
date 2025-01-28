//
//  MainPageHeaderButtonView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 19.01.2025.
//

import SwiftUI

struct MainPageHeaderButtonLabelView: View {
    let imageName: String
    var body: some View {
            Image(systemName: imageName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.clayBrown)
                .padding(5)
                .frame(width: 45, height: 45)
                .background(
                    Color.white.opacity(0.7)
                        .cornerRadius(16)
                )
    }
}

#Preview(traits: .sizeThatFitsLayout){
    MainPageHeaderButtonLabelView(imageName: "heart")
}
