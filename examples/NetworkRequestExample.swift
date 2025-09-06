import Foundation

struct PlayerRequest {
    let id: Int
    var urlRequest: URLRequest {
        var r = URLRequest(url: URL(string: "https://api.example.com/players/\(id)")!)
        r.httpMethod = "GET"
        r.timeoutInterval = 15
        return r
    }
}

struct PlayerResponse: Codable, Equatable {
    let id: Int
    let name: String
    let team: String
    let stats: [String: Double]
}

actor PlayerService {
    func fetchPlayer(id: Int) async throws -> PlayerResponse {
        let req = PlayerRequest(id: id).urlRequest
        var attempts = 0
        while true {
            do {
                let (data, resp) = try await URLSession.shared.data(for: req)
                guard let http = resp as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
                    throw URLError(.badServerResponse)
                }
                return try JSONDecoder().decode(PlayerResponse.self, from: data)
            } catch {
                attempts += 1
                if attempts >= 3 { throw error }
                try await Task.sleep(for: .seconds(pow(2, Double(attempts))))
            }
        }
    }
}