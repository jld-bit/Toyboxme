import Foundation
import UIKit

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published var records: [GenerationRecord] = []

    private let historyStore: GenerationHistoryStoring

    init(historyStore: GenerationHistoryStoring) {
        self.historyStore = historyStore
    }

    func load() {
        do {
            records = try historyStore.fetch()
        } catch {
            records = []
        }
    }

    func image(for record: GenerationRecord) -> UIImage? {
        guard let data = record.imageData else { return nil }
        return UIImage(data: data)
    }
}
