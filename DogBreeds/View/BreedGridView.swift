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
            AsyncImage(url: URL(string: imageURL), transaction: Transaction(animation: .spring(duration: 2, bounce: 0.5))) { phase in
                switch phase {
                case .success(let image):
                    image
                        .imageStyle()
                        .transition(.scale)
                        .clipShape(.circle)

                case .failure(_):
                    Image(systemName: "pawprint")
                        .imageStyle()
                        .foregroundStyle(.beige)

                case .empty:
                    Image(systemName: "pawprint")
                        .imageStyle()
                        .foregroundStyle(.beige)
                      
                @unknown default:
                    fatalError()
                }
            }
            
            Text(name)
                .font(.system(.footnote, design: .rounded, weight: .bold))
                .foregroundStyle(.beige)
                .lineLimit(2)
        }
        .padding(20)
        .background(
            Circle()
                .fill(.clayBrown)
                .overlay(alignment: .topLeading) {
                    Text("🐾")
                        .offset(x: 10, y: 10)
                        
                }
        )
       
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BreedGridView(imageURL: "https://api-ninjas.com/images/dogs/shih_tzu.jpg", name: "Shih Tzu")
}
