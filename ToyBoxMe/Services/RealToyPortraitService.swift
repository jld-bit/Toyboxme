import Foundation

struct RealToyPortraitService: ToyPortraitGenerating {
    let configuration: APIConfiguration
    private let client: APIClient

    init(configuration: APIConfiguration, client: APIClient = APIClient()) {
        self.configuration = configuration
        self.client = client
    }

    func generatePortrait(for request: PortraitRequest) async throws -> GenerationResponse {
        guard !configuration.apiKey.isEmpty else {
            throw AppError.invalidAPIConfiguration
        }

        let payload = RealGenerationPayload(
            prompt: request.prompt,
            imageBase64: request.selfieImageData.base64EncodedString(),
            responseFormat: "b64_json"
        )

        let endpoint = APIEndpoint(
            path: "/v1/generate",
            method: .post,
            body: try JSONEncoder().encode(payload)
        )

        // Placeholder implementation:
        // Replace `RealGenerationAPIResponse` with your provider schema.
        let response: RealGenerationAPIResponse = try await client.perform(
            endpoint,
            baseURL: configuration.baseURL,
            headers: ["Authorization": "Bearer \(configuration.apiKey)"]
        )

        let generatedData = Data(base64Encoded: response.imageBase64)

        return GenerationResponse(
            imageURL: URL(string: response.imageURL ?? ""),
            imageData: generatedData,
            requestID: response.requestID,
            providerName: "ConfiguredProvider"
        )
    }
}

private struct RealGenerationPayload: Codable {
    let prompt: String
    let imageBase64: String
    let responseFormat: String
}

private struct RealGenerationAPIResponse: Codable {
    let requestID: String
    let imageURL: String?
    let imageBase64: String
}
