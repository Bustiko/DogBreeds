//
//  TraitGridView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 21.01.2025.
//

import SwiftUI

struct TraitsGridView: View {
    let traits: [(String, Int)]
    var body: some View {
        Grid {
            ForEach(traits, id: \.0) { trait in
                if trait.1 != 0 {
                    GridRow {
                        Text(trait.0)
                            .modifier(DetailsGridTextModifier())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            ForEach(0..<trait.1, id: \.self) { _ in
                                Image(systemName: "pawprint.fill")
                                    .foregroundColor(.beige)
                            }
                            Spacer()
                        }// HSTACK
                    }// GRIDROW
                }
            }// FOREACH
        }// GRID
        .modifier(DetailsGridViewModifier())
    }
}

#Preview {
    TraitsGridView(traits: [("Playfulness", 2), ("Barking", 1)])
}
