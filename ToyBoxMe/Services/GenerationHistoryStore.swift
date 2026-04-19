import Foundation

protocol GenerationHistoryStoring {
    func fetch() throws -> [GenerationRecord]
    func save(_ records: [GenerationRecord]) throws
}

struct LocalGenerationHistoryStore: GenerationHistoryStoring {
    private let fileManager: FileManager = .default
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private var fileURL: URL {
        let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("generation_history.json")
    }

    func fetch() throws -> [GenerationRecord] {
        guard fileManager.fileExists(atPath: fileURL.path) else { return [] }
        let data = try Data(contentsOf: fileURL)
        return try decoder.decode([GenerationRecord].self, from: data)
    }

    func save(_ records: [GenerationRecord]) throws {
        let data = try encoder.encode(records)
        try data.write(to: fileURL, options: .atomic)
    }
}
