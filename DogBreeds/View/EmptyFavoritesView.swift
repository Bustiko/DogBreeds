//
//  EmptyFavoritesView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct EmptyFavoritesView: View {
    var body: some View {
        HStack {
            Image(systemName: "pawprint")
                .font(.system(size: 50, weight: .bold))
            Text("Add breeds to your favorites list to see them here!")
                .font(.headline)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.clayBrown)
        .foregroundStyle(Color.beige)
    }
}

#Preview {
    EmptyFavoritesView()
}
