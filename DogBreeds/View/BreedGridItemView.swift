//
//  BreedGridView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 17.01.2025.
//

import SwiftUI

struct BreedGridItemView: View {
    let imageURL: String
    let name: String
    
    var body: some View {
        VStack {
            // Dog photo
            DogPhotoView(imageURL: imageURL)
                .padding(20)
                .frame(height: 150)
                
            
            // Divider separating image and name
            Divider()
                .frame(height: 2)
                .background(.white)

            // Breed name
            Text(name)
                .font(.system(size: 23, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .minimumScaleFactor(0.7)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .frame(height: 40)
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.clayBrown)

        )
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BreedGridItemView(imageURL: "https://api-ninjas.com/images/dogs/shih_tzu.jpg", name: "Shih Tzu")
}
