//
//  Extensions.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 17.01.2025.
//

import SwiftUI

extension Image {
    func imageStyle() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func fallbackImageStyle() -> some View {
        self
            .imageStyle()
            .foregroundStyle(Color.white)
    }
}
