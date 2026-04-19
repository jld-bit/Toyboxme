import Photos
import UIKit

struct PhotoLibraryService {
    func requestAccess() async -> PHAuthorizationStatus {
        await PHPhotoLibrary.requestAuthorization(for: .addOnly)
    }

    func save(image: UIImage) async throws {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        guard status == .authorized || status == .limited else {
            throw AppError.photoPermissionDenied
        }

        try await PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }
    }
}
