import Foundation

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

struct SearchResponse: Codable {
    let results: [Recipe]
}

struct Recipe: Codable, Hashable {
    let id: Int
    let title: String
    let readyInMinutes: Int?
    let image: String?
    let instructions: String?
    let spoonacularScore: Double?
    let sourceName: String?
	let extendedIngredients: [Ingredient]?
    
    var time: String {
        guard let readyInMinutes else { return "" }
        let hours = readyInMinutes / 60
        let minutes = readyInMinutes % 60
        return String(format: "%02d:%02d", hours, minutes)
    }
    
    var stars: String {
        guard let spoonacularScore else { return "" }
        let value = 5 * spoonacularScore / 100
        return String(format: "%0.1f", value)
    }
	
	var numberOfIngredients: Int {
        extendedIngredients?.count ?? 0
	}
    
    static var sample: Recipe {
        Bundle.main.decode([Recipe].self, from: "Recipes.json")[0]
    }
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

