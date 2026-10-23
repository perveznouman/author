import Foundation

class Network {
    func fetch<T: Decodable>(urlString: String) async throws -> T {
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
