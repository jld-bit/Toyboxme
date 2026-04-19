import SwiftUI

struct ColorTheme: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let hexPrimary: String
    let hexSecondary: String

    var gradient: LinearGradient {
        LinearGradient(
            colors: [Color(hex: hexPrimary), Color(hex: hexSecondary)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    static let playfulThemes: [ColorTheme] = [
        .init(id: "sunburst", name: "Sunburst", hexPrimary: "#FF8A00", hexSecondary: "#FFD600"),
        .init(id: "bubblegum", name: "Bubblegum", hexPrimary: "#FF3CAC", hexSecondary: "#784BA0"),
        .init(id: "ocean-pop", name: "Ocean Pop", hexPrimary: "#00C9FF", hexSecondary: "#92FE9D"),
        .init(id: "berry-fizz", name: "Berry Fizz", hexPrimary: "#F857A6", hexSecondary: "#FF5858"),
        .init(id: "arcade", name: "Arcade", hexPrimary: "#7F00FF", hexSecondary: "#E100FF")
    ]
}
