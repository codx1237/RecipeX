//
//  FavoriteRecipeDetail.swift
//  RecipeX
//
//  Created by Fırat Ören on 23.09.2024.
//

import SwiftUI
import SwiftData

struct FavoriteRecipeDetail: View {
    let favRecipe: FavoriteRecipes
    @Environment(\.modelContext) private var modelContext
    @Query private var favRecipes: [FavoriteRecipes]
    @Environment(\.dismiss) private var dissmiss

    var body: some View {
        ScrollView {
            VStack{
                Text(favRecipe.name)
                    .foregroundStyle(Color("ButtonColor"))
                    .font(.title2)
                    .bold()
                HStack{
                    ForEach(favRecipe.tags,id: \.self) { tag in
                        Text(tag)
                            .foregroundStyle(Color("ButtonColor"))
                    }
                    Spacer()
                }.padding(.horizontal)


                AsyncImage(url: URL(string: favRecipe.image)) { img in
                    img
                        .resizable()
                        .clipped()
                        .frame(maxWidth: .infinity,maxHeight: UIScreen.main.bounds.width * 0.5)
                        .padding(.horizontal)

                } placeholder: {
                    ProgressView("loading")
                        .frame(width: 300,height: 200)
                }
                HStack{
                    Button(action: {

                    }, label: {
                        HStack{
                            Image("play")
                                .resizable()
                                .frame(width: 25,height: 25)

                            Text("Share")
                        }   .frame(width: 150,height: 40)
                            .background(Color.gray.opacity(0.5))
                            .foregroundStyle(Color("ButtonColor"))
                            .font(.system(size: 18,weight: .bold))
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                    })
                    Spacer()
                    Button(action: {

                    }, label: {
                        HStack{
                            Image("share")
                                .resizable()
                                .frame(width: 25,height: 25)
                                
                            Text("Share")
                        }   .frame(width: 150,height: 40)
                            .background(Color.gray.opacity(0.5))
                            .foregroundStyle(Color("ButtonColor"))
                            .font(.system(size: 18,weight: .bold))
                            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))

                    })
                }.padding(.top)
                    .padding(.horizontal)
                Button(action: {
                    withAnimation {
                        modelContext.delete(favRecipe)
                        try! modelContext.save()
                        dissmiss()
                    }
                }, label: {
                    Text("Remove from Favorites")
                        .frame(width: 250,height: 40)
                        .background(Color.gray.opacity(0.5))
                        .foregroundStyle(Color.red)
                        .font(.system(size: 18,weight: .semibold))
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .padding(6)
                })
                Divider()
                VStack{
                    HStack{
                        HStack{
                            Text("Time")
                                .bold()
                            Text("\(favRecipe.prepTimeMinutes) mins")
                        }
                        Spacer()
                        HStack{
                            Text("Difficulty")
                                .bold()
                            Text("\(favRecipe.difficulty)")
                        }
                    }
                    HStack{
                        HStack{
                            Text("Serving")
                                .bold()
                            Text("\(favRecipe.servings)")
                        }
                        Spacer()
                        HStack{
                            Text("Calories per Serving")
                                .bold()
                            Text("\(favRecipe.caloriesPerServing)")
                        }
                    }
                }.padding()

                Divider()
                Text("Ingredients").frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading)
                    .foregroundStyle(Color("ButtonColor"))
                    .font(.title3)
                    .bold()

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(favRecipe.ingredients,id: \.self) { ing in
                            VStack(alignment:.leading){
                                Image("image3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150,height: 150)
                                    .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                                Text(ing)
                                   // .frame(width: 150)
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color("ButtonColor"))
                            }.frame(width: 160,height: 200,alignment: .topLeading)
                              //  .background(Color.gray)

                        }

                    }.padding(.horizontal)
                }

                Text("Instructions").frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.leading)
                    .foregroundStyle(Color("ButtonColor"))
                    .font(.title3)
                    .bold()

                VStack(alignment:.leading,spacing: 12){
                    ForEach(favRecipe.instructions,id: \.self) { ins in
                        Text("⎯ \(ins)")
                            .font(.footnote).bold()
                    }
                }.padding(.leading).padding(.top)

                Spacer()
            }.navigationBarTitleDisplayMode(.inline)
                .onAppear {

                }
        }.scrollIndicators(.hidden)
    }
}









#Preview {
    FavoriteRecipeDetail(favRecipe: FavoriteRecipes(id: 1, name: "Classic Margherita Pizza", ingredients: ["Pizza dough","Tomato sauce","Fresh mozzarella cheese","Fresh basil leaves","Olive oil","Salt and pepper to taste"], instructions: ["Preheat the oven to 475°F (245°C).","Roll out the pizza dough and spread tomato sauce evenly.","Top with slices of fresh mozzarella and fresh basil leaves.","Drizzle with olive oil and season with salt and pepper.","Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.", "Slice and serve hot."], prepTimeMinutes: 20, difficulty: "Easy", cuisine: "Italian", servings: 4, caloriesPerServing: 300, tags: ["Pizza","Italian"], rating: 4.6, mealType: ["Dinner"], image: "https://cdn.dummyjson.com/recipe-images/1.webp"))
}
