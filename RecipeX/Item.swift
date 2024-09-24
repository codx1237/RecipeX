//
//  Item.swift
//  RecipeX
//
//  Created by Fırat Ören on 23.09.2024.
//

import Foundation
import SwiftData

@Model
final class User {
    var email: String
    var password: String
    var name: String

    init(email: String, password: String, name: String) {
        self.email = email
        self.password = password
        self.name = name
    }
}

@Model
final class FavoriteRecipes {
    var id: Int
    var name: String
    var ingredients: [String]
    var instructions: [String]
    var prepTimeMinutes: Int
    var difficulty: String
    var cuisine: String
    var servings: Int
    var caloriesPerServing: Int
    var tags: [String]
    var rating: Double
    var mealType: [String]
    var image: String

    init(id: Int, name: String, ingredients: [String], instructions: [String], prepTimeMinutes: Int, difficulty: String, cuisine: String, servings: Int, caloriesPerServing: Int, tags: [String], rating: Double, mealType: [String], image: String) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.prepTimeMinutes = prepTimeMinutes
        self.difficulty = difficulty
        self.cuisine = cuisine
        self.servings = servings
        self.caloriesPerServing = caloriesPerServing
        self.tags = tags
        self.rating = rating
        self.mealType = mealType
        self.image = image
    }

}

