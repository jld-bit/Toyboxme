import Foundation
import PhotosUI
import SwiftUI
import UIKit

@MainActor
final class BuilderViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem?
    @Published var selfieImage: UIImage?
    @Published var characterName = "Nova"
    @Published var selectedPreset: StylePreset = .explorer
    @Published var accessoryLabels: [AccessoryLabel] = [
        .init(text: "Backpack"),
        .init(text: "Sticker"),
        .init(text: "Mini Tool")
    ]
    @Published var selectedTheme: ColorTheme = ColorTheme.playfulThemes[0]

    @Published var isGenerating = false
    @Published var generatedImage: UIImage?
    @Published var errorMessage: String?
    @Published var showShareSheet = false

    private let generationService: ToyPortraitGenerating
    private let historyStore: GenerationHistoryStoring
    private let photoService = PhotoLibraryService()

    init(generationService: ToyPortraitGenerating, historyStore: GenerationHistoryStoring) {
        self.generationService = generationService
        self.historyStore = historyStore
    }

    func loadSelectedImage() async {
        do {
            if let data = try await selectedItem?.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                selfieImage = image
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func generate(retryCount: Int = 1) async {
        guard let selfieImage, let imageData = selfieImage.jpegData(compressionQuality: 0.95) else {
            errorMessage = AppError.missingSelfie.localizedDescription
            return
        }

        isGenerating = true
        errorMessage = nil

        do {
            let request = PortraitRequest(
                selfieImageData: imageData,
                characterName: characterName,
                stylePreset: selectedPreset,
                accessoryLabels: accessoryLabels,
                colorTheme: selectedTheme
            )

            let response = try await generationService.generatePortrait(for: request)
            if let data = response.imageData, let image = UIImage(data: data) {
                generatedImage = image
                try persistRecord(imageData: data, imageURL: response.imageURL)
            } else {
                throw AppError.generationFailed(message: "No image was returned")
            }
        } catch {
            if retryCount > 0 {
                await generate(retryCount: retryCount - 1)
                return
            }
            errorMessage = error.localizedDescription
        }

        isGenerating = false
    }

    func saveToPhotos() async {
        guard let generatedImage else { return }

        do {
            let status = await photoService.requestAccess()
            guard status == .authorized || status == .limited else {
                throw AppError.photoPermissionDenied
            }
            try await photoService.save(image: generatedImage)
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    private func persistRecord(imageData: Data, imageURL: URL?) throws {
        var records = try historyStore.fetch()
        let record = GenerationRecord(
            characterName: characterName,
            stylePreset: selectedPreset,
            colorTheme: selectedTheme,
            imageURL: imageURL,
            imageData: imageData
        )
        records.insert(record, at: 0)
        try historyStore.save(Array(records.prefix(50)))
    }
}
