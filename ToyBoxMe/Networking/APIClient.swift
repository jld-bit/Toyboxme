import Foundation

struct APIClient {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func perform<T: Decodable>(
        _ endpoint: APIEndpoint,
        baseURL: URL,
        headers: [String: String] = [:]
    ) async throws -> T {
        var request = URLRequest(url: baseURL.appending(path: endpoint.path))
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers.forEach { key, value in request.setValue(value, forHTTPHeaderField: key) }

        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse else {
            throw AppError.generationFailed(message: "Invalid server response")
        }

        guard (200...299).contains(http.statusCode) else {
            throw AppError.generationFailed(message: "Server returned status \(http.statusCode)")
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
