//
//  PersonView.swift
//  RecipeX
//
//  Created by Fırat Ören on 24.09.2024.
//

import SwiftUI
import SwiftData

struct PersonView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var users: [User]
    @Query private var favRecipes: [FavoriteRecipes]
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some View {
        VStack(alignment:.leading) {
            if let user = users.first {
                Text("\(user.name)")
                    .padding()
                    .frame(maxWidth: .infinity,maxHeight: 100,alignment: .bottomLeading)
                    .background(Color("ButtonColor"))
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .bold()

                Text("You have \(favRecipes.count) favorite recipes")
                    .font(.headline)
                    .padding()

                Spacer()

                HStack{
                    Spacer()
                    Button {
                        isLoggedIn = false
                    } label: {
                        Text("Log Out")
                            .frame(width: 250,height: 50)
                            .foregroundStyle(Color("ButtonColor"))
                            .font(.system(size: 25,weight: .semibold))
                            .background(Color.yellow.opacity(0.5))
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                            .padding()
                    }
                    Spacer()
                }
            } else {
                Text("No user found")
            }



            

        }

    }
}

#Preview {
    PersonView()
}
