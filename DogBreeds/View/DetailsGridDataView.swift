//
//  DetailsGridDataView.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 20.01.2025.
//

import SwiftUI

struct DetailsGridDataView: View {
    let gender: Constants.Gender
    let weightRange: (min: Double, max: Double)
    let heightRange: (min: Double, max: Double)
    
    var body: some View {
        GridRow {
            Text("\(gender.rawValue)")
                .modifier(DetailsGridTextModifier())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("\(String(format: "%.f - %.f", arguments: [heightRange.min.rounded(), heightRange.max.rounded()]))")
                .fixedSize()
            Text("\(String(format: "%.f - %.f", arguments: [weightRange.min.rounded(), weightRange.max.rounded()]))")
                .fixedSize()
        }
    }
}

#Preview {
    DetailsGridDataView(gender: .male, weightRange: (12.0, 13.0), heightRange: (15.9, 16.9))
}
