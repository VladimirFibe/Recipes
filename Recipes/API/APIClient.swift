import Foundation

final class APIClient {
    static let shared = APIClient()
    private init() {}
    
    func request<Response: Decodable>(_ route: APIRoute) async throws -> Response {
        guard let request = route.request else { throw APIError.failedRequest}
        let (data, _) = try await URLSession.shared.data(for: request)
        print(String(data: data, encoding: .utf8) ?? "")
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let result = try? decoder.decode(Response.self, from: data)
        else {
            print("kapets")
            throw APIError.failedTogetData
        }
        return result
    }
}
