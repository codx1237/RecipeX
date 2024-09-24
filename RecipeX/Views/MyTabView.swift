//
//  MyTabView.swift
//  RecipeX
//
//  Created by Fırat Ören on 17.09.2024.
//

import SwiftUI

struct MyTabView: View {
    @ObservedObject var recipeManager = RecipeManager()
    var body: some View {
        TabView {
            HomeView(recipeManager: recipeManager)
                .tabItem {
                    Label("home", systemImage: "house")
                }
            FavoriteView()
                .tabItem {
                    Label("favorite meals", systemImage: "heart")
                }
            PersonView()
                .tabItem {
                    Label("Profile",systemImage: "person")
                }
        }.tint(Color.black)
    }
}

#Preview {
    MyTabView()
}
