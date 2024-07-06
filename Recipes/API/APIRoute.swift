import Foundation

enum APIRoute {
    case getRecipeInformation(GetRecipeInformationRequest)
    case searchRecipes(SearchRecipesRequest)
    case getRandomRecipes

    var baseUrl: String {
        "https://api.spoonacular.com/"
    }
    
    var fullUrl: String {
        switch self {
        case .getRecipeInformation(let request): "\(baseUrl)recipes/\(request.id)/information"
        case .searchRecipes(_): "\(baseUrl)recipes/complexSearch"
        case .getRandomRecipes: "\(baseUrl)recipes/random"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .getRandomRecipes: return [.init(name: "number", value: "10")]
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
