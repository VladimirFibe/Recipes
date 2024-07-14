//
//  IngredientsLoader.swift
//  Recipes
//
//  Created by Ольга Чушева on 13.07.2024.
//

import Foundation
struct IngredientsLoader {
    lazy var ingredientsByID = 1003464

    // MARK: - NetworkClient
    private let networkClient = IngredientsNetworkClient()
    
    // MARK: - URL
    private var recipeUrl: URL {
        // Если мы не смогли преобразовать строку в URL, то приложение упадёт с ошибкой
        guard let url = URL(string: "https://api.spoonacular.com/recipes/id/information") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        return url
    }
    
    func loadIngredients(handler: @escaping (Result<[Ingredient], Error>) -> Void) {
        
        networkClient.fetch(url: recipeUrl ) { result in
                switch result {
                case .success(let data):
                    do {
                        let ingredient = try JSONDecoder().decode([Ingredient].self, from: data)
                        handler(.success(ingredient))
                    } catch {
                        handler(.failure(error))
                    }
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
    
    }

