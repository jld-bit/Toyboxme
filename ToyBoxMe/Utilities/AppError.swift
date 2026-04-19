import Foundation

enum AppError: LocalizedError {
    case missingSelfie
    case generationFailed(message: String)
    case invalidAPIConfiguration
    case photoPermissionDenied
    case failedToSaveImage

    var errorDescription: String? {
        switch self {
        case .missingSelfie:
            return "Please select a selfie to continue."
        case let .generationFailed(message):
            return "Image generation failed: \(message)"
        case .invalidAPIConfiguration:
            return "API configuration is missing. Add your API key configuration file."
        case .photoPermissionDenied:
            return "Photo permission denied. Enable it in Settings."
        case .failedToSaveImage:
            return "Could not save image to Photos."
        }
    }
}
