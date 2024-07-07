import Foundation

enum HomeSection: Int, CaseIterable {
    case trending
    case popular
    case recent
    
    var title: String {
        switch self {
        case .trending: return "Trending now 🔥"
        case .popular: return "Popular category"
        case .recent: return "Recent recipe"
        }
    }
}
