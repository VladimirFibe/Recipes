import Foundation

struct Ingredient: Codable, Hashable {
    let id: Int
    let image: String?
    let name: String
    let amount: Double
    let unit: String

    var sourceImage: String? {
        guard let image else { return nil }
        return "https://spoonacular.com/cdn/ingredients_100x100/\(image)"
    }
}
