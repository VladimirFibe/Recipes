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
    let spoonacularScore: Double
    let sourceName: String
    
    var time: String {
        let hours = readyInMinutes / 60
        let minutes = readyInMinutes % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    var stars: String {
        let value = 5 * spoonacularScore / 100
        return String(format: "%0.1f", value)
    }
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
