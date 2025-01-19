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
            .frame(width: 50, height: 50)
            .foregroundStyle(Color.white)
    }
}
