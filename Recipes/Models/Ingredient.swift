import Foundation

struct Ingredient: Codable, Hashable {
    var id: Int = 0
    var image: String?
    var name: String
    var amount: Double = 0
    var unit: String = ""
    var quantity: String? = ""
    var sourceImage: String? {
        guard let image else { return nil }
        return "https://spoonacular.com/cdn/ingredients_100x100/\(image)"
    }
}
