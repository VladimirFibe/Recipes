import Foundation

enum APIRoute {
    case getRecipeInformation(GetRecipeInformationRequest)
    case searchRecipes(SearchRecipesRequest)
    case getRandomRecipes(GetRandomRecipesRequest)

    var baseUrl: String {
        "https://api.spoonacular.com/"
    }
    
    var fullUrl: String {
        switch self {
        case .getRecipeInformation(let request): return "\(baseUrl)recipes/\(request.id)/information"
        case .searchRecipes(_): return "\(baseUrl)recipes/complexSearch"
        case .getRandomRecipes: return "\(baseUrl)recipes/random"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getRandomRecipes(let value): return [.init(name: "number", value: "\(value.number)")]
        default: return []
        }
    }

    var httpMethod: String {
        "GET"
    }
    
    var key: String {
        (Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String) ?? ""
    }
    
    var allHTTPHeaderFields: [String: String] {
        ["accept": "application/json", "x-api-key": key]
    }
    
    var request: URLRequest? {
        guard let url = URL(string: fullUrl),
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        else { return nil }
        components.queryItems = queryItems
        var request = URLRequest(url: components.url ?? url)
        request.httpMethod = httpMethod
        request.timeoutInterval = 10
        print(allHTTPHeaderFields)
        request.allHTTPHeaderFields = allHTTPHeaderFields
        return request
    }
}

struct GetRecipeInformationRequest {
    let id: Int
}

struct SearchRecipesRequest {
    let query: String = ""
}

struct GetRandomRecipesRequest {
    let number: Int
}
