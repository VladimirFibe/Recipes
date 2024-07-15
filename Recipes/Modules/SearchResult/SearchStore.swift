import Combine

enum SearchEvent {
    case done([Recipe])
}

enum SearchAction {
    case get(String)
}

final class SearchStore: Store<SearchEvent, SearchAction> {
    override func handleActions(action: SearchAction) {
        switch action {
        case .get(let query):
            statefulCall {
                try await self.get(query)
            }
        }
    }
    
    private func get(_ query: String) async throws {
        let response: SearchResponse = try await APIClient.shared.request(.searchRecipes(SearchRecipesRequest(query: query)))
        sendEvent(.done(response.results))
    }
}
