//
//  DetailsPageToolbarItemView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 20.01.2025.
//

import SwiftUI

struct DetailsPageToolbarItemView: View {
    let imageName: String
    var body: some View {
        Image(systemName: imageName)
                .font(.system(.title3, design: .rounded, weight: .black))
                .foregroundColor(Color.clayBrown)
                .accessibilityIdentifier("DetailsToolbarItem-\(imageName)")
    }
}

#Preview {
    DetailsPageToolbarItemView(imageName: "chevron.left")
}
