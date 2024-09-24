//
//  RecipeXApp.swift
//  RecipeX
//
//  Created by Fırat Ören on 16.09.2024.
//

import SwiftUI
import SwiftData

@main
struct RecipeXApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            FavoriteRecipes.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            RootView()
                .modelContainer(sharedModelContainer)

        }
    }
}
