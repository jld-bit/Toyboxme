import Foundation

protocol ToyPortraitGenerating {
    func generatePortrait(for request: PortraitRequest) async throws -> GenerationResponse
}

struct GenerationResponse: Codable {
    let imageURL: URL?
    let imageData: Data?
    let requestID: String
    let providerName: String
}
