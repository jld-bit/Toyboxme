import SwiftUI

enum StylePreset: String, CaseIterable, Identifiable, Codable {
    case explorer
    case retroHero
    case officeLegend
    case athlete
    case musician
    case cosmicAdventurer

    var id: String { rawValue }

    var title: String {
        switch self {
        case .explorer: return "Explorer"
        case .retroHero: return "Retro Hero"
        case .officeLegend: return "Office Legend"
        case .athlete: return "Athlete"
        case .musician: return "Musician"
        case .cosmicAdventurer: return "Sci‑Fi"
        }
    }

    var promptDescriptor: String {
        switch self {
        case .explorer:
            return "adventurous character with practical outdoor gear"
        case .retroHero:
            return "bold vintage-inspired character with playful confidence"
        case .officeLegend:
            return "professional character with polished desk-side accessories"
        case .athlete:
            return "energetic sports-themed character with dynamic outfit"
        case .musician:
            return "creative performer character with stage-ready details"
        case .cosmicAdventurer:
            return "futuristic space explorer character with imaginative gadgets"
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .explorer:
            return LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .retroHero:
            return LinearGradient(colors: [.orange, .pink], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .officeLegend:
            return LinearGradient(colors: [.blue, .cyan], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .athlete:
            return LinearGradient(colors: [.red, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .musician:
            return LinearGradient(colors: [.purple, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .cosmicAdventurer:
            return LinearGradient(colors: [.indigo, .teal], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}
