//
//  Modifiers.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 19.01.2025.
//

import SwiftUI

struct GradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [.beige, .clayBrown.opacity(0.2)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

struct DetailsGridViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title3, design: .rounded, weight: .bold))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.clayBrown)
            .clipShape(.rect(cornerRadius: 16))
    }
}
struct DetailsGridTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.clayBrown)
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 16).fill(Color.beige))
    }
}

