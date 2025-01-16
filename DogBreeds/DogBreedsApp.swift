//
//  DogBreedsApp.swift
//  DogBreeds
//
//  Created by Buse Karabıyık on 16.01.2025.
//

import SwiftUI

@main
struct DogBreedsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainPageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
