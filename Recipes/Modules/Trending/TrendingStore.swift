import Combine

enum TrendingEvent {
    case done([Recipe])
}

enum TrendingAction {
    case get
}

final class TrendingStore: Store<TrendingEvent, TrendingAction> {
    override func handleActions(action: TrendingAction) {
        switch action {
        case .get:
            statefulCall {
                try await self.get()
            }
        }
    }
    
    private func get() async throws {
        let response: RecipesResponse = try await APIClient.shared.request(.getRandomRecipes(.init(number: 5)))
        sendEvent(.done(response.recipes))
    }
}
