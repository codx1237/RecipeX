//
//  Recipe.swift
//  RecipeX
//
//  Created by Fırat Ören on 17.09.2024.
//

import Foundation



enum Categories: String, CaseIterable {
    case breakfast = "Breakfast"
    case dinner = "Dinner"
    case lunch = "Lunch"
    case beverage = "Beverage"
    case side_dish    = "Side Dish"
    case snacks    = "Snacks"
    case dessert = "Dessert"

}

struct Categ:Identifiable,Hashable {
    let id = UUID()
    let category: Categories
}


struct Recipe: Hashable,Decodable,Identifiable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let difficulty: String
    let cuisine: String
    let servings: Int
    let caloriesPerServing: Int
    let tags: [String]
    let rating: Double
    let mealType: [String]
    let image: String
}


struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}
