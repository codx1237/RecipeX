//
//  RecipeManager.swift
//  RecipeX
//
//  Created by Fırat Ören on 17.09.2024.
//

import SwiftUI

@MainActor
class RecipeManager: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var recipesByCategory: [Recipe] = []


    func fetchRecipes() async {
        do{
            self.recipes = try await fetchRecipesFromApi()
        } catch {
            print("error fething \(error.localizedDescription)")
        }
    }

    func fetchRecipesByCategory(category: String) async {
        do{
            self.recipesByCategory = try await fetchRecipesByCategoryFromApi(category: category)
        } catch {
            print("error fething \(error.localizedDescription)")
        }
    }

    private func fetchRecipesByCategoryFromApi(category: String) async throws -> [Recipe] {
        guard let url = URL(string: "https://dummyjson.com/recipes/meal-type/\(category)") else {
            throw NetworkError.badUrl
        }
        let (data,response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        guard let recipeResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
            throw NetworkError.decodingError
        }
        return recipeResponse.recipes
    }


    private func fetchRecipesFromApi() async throws -> [Recipe] {
        guard let url = URL(string: "https://dummyjson.com/recipes") else {
            throw NetworkError.badUrl
        }

        let (data,response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        guard let recipeResponse = try? JSONDecoder().decode(RecipeResponse.self, from: data) else {
            throw NetworkError.decodingError
        }
        return recipeResponse.recipes

    }




}


enum NetworkError: Error {
    case badUrl
    case badRequest
    case decodingError
}
