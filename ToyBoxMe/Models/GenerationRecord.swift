import Foundation

struct GenerationRecord: Identifiable, Codable, Hashable {
    let id: UUID
    let createdAt: Date
    let characterName: String
    let stylePreset: StylePreset
    let colorTheme: ColorTheme
    let imageURL: URL?
    let imageData: Data?

    init(
        id: UUID = UUID(),
        createdAt: Date = Date(),
        characterName: String,
        stylePreset: StylePreset,
        colorTheme: ColorTheme,
        imageURL: URL?,
        imageData: Data?
    ) {
        self.id = id
        self.createdAt = createdAt
        self.characterName = characterName
        self.stylePreset = stylePreset
        self.colorTheme = colorTheme
        self.imageURL = imageURL
        self.imageData = imageData
    }
}
