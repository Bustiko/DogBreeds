//
//  DogPhotoView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 19.01.2025.
//

import SwiftUI

struct DogPhotoView: View {
    let imageURL: String
    var body: some View {
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
    }
}

#Preview {
    DogPhotoView(imageURL: "https://api-ninjas.com/images/dogs/shih_tzu.jpg")
}
