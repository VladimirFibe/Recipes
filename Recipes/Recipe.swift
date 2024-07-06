import Foundation

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Hashable {
    let id: Int
    let title: String
    let readyInMinutes: Int
    let image: String
    let instructions: String
}

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let results: [SearchRecipe]
    let offset, number, totalResults: Int
}

// MARK: - SearchRecipe
struct SearchRecipe: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: ImageType
}

enum ImageType: String, Codable {
    case jpg
}
