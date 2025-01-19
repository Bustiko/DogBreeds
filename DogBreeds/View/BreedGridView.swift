//
//  BreedGridView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 17.01.2025.
//

import SwiftUI

struct BreedGridView: View {
    let imageURL: String
    let name: String
    
    var body: some View {
        VStack {
            // Asynchronous image loading with fallbacks
            AsyncImage(
                url: URL(string: imageURL),
                transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.7))
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .imageStyle()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.beige, lineWidth: 2)
                                .shadow(
                                    color: Color.beige.opacity(1),
                                    radius: 4
                                )
                        )
                        .transition(.scale)

                case .failure, .empty:
                    Image(systemName: "pawprint")
                        .fallbackImageStyle()
                    
                @unknown default:
                    fatalError("Unexpected AsyncImage phase")
                }
            }
            .padding(20)
            
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
    BreedGridView(imageURL: "https://api-ninjas.com/images/dogs/shih_tzu.jpg", name: "Shih Tzu")
}
