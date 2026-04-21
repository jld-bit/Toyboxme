import Foundation
import UIKit

struct MockToyPortraitService: ToyPortraitGenerating {
    func generatePortrait(for request: PortraitRequest) async throws -> GenerationResponse {
        try await Task.sleep(for: .seconds(1.25))

        guard let image = UIImage(data: request.selfieImageData) else {
            throw AppError.generationFailed(message: "The selected selfie is unreadable.")
        }

        let rendered = image.withRoundedCorners(radius: 36)
        let data = rendered.jpegData(compressionQuality: 0.92)

        return GenerationResponse(
            imageURL: URL(string: "https://mock.api.toyboxme.dev/v1/images/sample-portrait-001.jpg"),
            imageData: data,
            requestID: UUID().uuidString,
            providerName: "MockGenerator"
        )
    }
}

private extension UIImage {
    func withRoundedCorners(radius: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: radius).addClip()
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
