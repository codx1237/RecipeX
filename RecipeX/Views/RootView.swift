//
//  RootView.swift
//  RecipeX
//
//  Created by Fırat Ören on 17.09.2024.
//

import SwiftUI

struct RootView: View {
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        VStack{
            if isLoggedIn {
                MyTabView()
            } else {
                WelcomeView()
            }
        }
    }
}

#Preview {
    RootView()
}
