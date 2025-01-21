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
                .foregroundColor(.clayBrown)
            Text("Add breeds to your favorites list to see them here!")
                .font(.headline)
                .foregroundColor(.clayBrown)
        }
    }
}

#Preview {
    EmptyFavoritesView()
}
