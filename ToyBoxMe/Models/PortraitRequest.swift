import Foundation

struct PortraitRequest: Codable {
    let selfieImageData: Data
    let characterName: String
    let stylePreset: StylePreset
    let accessoryLabels: [AccessoryLabel]
    let colorTheme: ColorTheme

    var prompt: String {
        let accessories = accessoryLabels
            .map(\.text)
            .filter { !$0.isEmpty }
            .joined(separator: ", ")

        return """
        Create an original toy-box inspired collectible portrait using the provided person reference. \
        Theme: \(stylePreset.promptDescriptor). \
        Character name: \(characterName). \
        Accessory callouts: \(accessories.isEmpty ? "none" : accessories). \
        Packaging colors: primary \(colorTheme.hexPrimary), secondary \(colorTheme.hexSecondary). \
        Use generic, non-branded visual language and avoid celebrity or trademark references.
        """
    }
}
