//
//  FavoriteView.swift
//  RecipeX
//
//  Created by Fırat Ören on 17.09.2024.
//

import SwiftUI
import SwiftData

struct FavoriteView: View {
    @Query private var favoriteRecipes: [FavoriteRecipes]



    var body: some View {
        NavigationView {
            VStack{
                List(favoriteRecipes) { recipe in
                    NavigationLink {
                        FavoriteRecipeDetail(favRecipe: recipe)
                    } label: {
                        HStack{
                            AsyncImage(url: URL(string: recipe.image)) { img in
                                img.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100,height: 100)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView("loading")
                                    .frame(width: 100,height: 100)
                                    .clipShape(Circle())
                            }
                            
                            VStack(alignment:.leading){
                                Text(recipe.name)
                                    .foregroundStyle(Color("ButtonColor"))
                                    .font(.system(size: 15,weight: .bold))
                                Text(recipe.cuisine)
                                HStack{
                                    Button(action: {}, label: {
                                        Text(recipe.difficulty)
                                            .padding(8)
                                            .foregroundStyle(Color("ButtonColor"))
                                            .font(.system(size: 12,weight: .bold))
                                            .background(Color.gray.opacity(0.5))
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 18, height: 18)))
                                        
                                    })
                                    
                                    Button(action: {}, label: {
                                        Text("\(recipe.prepTimeMinutes) mins")
                                            .padding(8)
                                            .foregroundStyle(Color("ButtonColor"))
                                            .font(.system(size: 12,weight: .bold))
                                            .background(Color.gray.opacity(0.5))
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 18, height: 18)))
                                        
                                    })
                                    
                                    Button(action: {}, label: {
                                        Text("\(String(format:"%.2f",recipe.rating))")
                                            .padding(8)
                                            .foregroundStyle(Color("ButtonColor"))
                                            .font(.system(size: 12,weight: .bold))
                                            .background(Color.gray.opacity(0.5))
                                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 18, height: 18)))
                                        
                                    })
                                    
                                    
                                }
                                
                            }
                        }
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Favorite Recipes")
            .onAppear {

            }
        }
    }
}

#Preview {
    FavoriteView()
}
