import Foundation

final class AppContainer: ObservableObject {
    let generationService: ToyPortraitGenerating
    let historyStore: GenerationHistoryStoring
    let imageCache: ImageCaching

    init(
        generationService: ToyPortraitGenerating,
        historyStore: GenerationHistoryStoring,
        imageCache: ImageCaching
    ) {
        self.generationService = generationService
        self.historyStore = historyStore
        self.imageCache = imageCache
    }

    static func makeDefault() -> AppContainer {
        let cache = ImageCache()
        let service: ToyPortraitGenerating

        #if DEBUG
        service = MockToyPortraitService()
        #else
        service = RealToyPortraitService(configuration: APIConfiguration.load())
        #endif

        let historyStore = LocalGenerationHistoryStore()

        return AppContainer(
            generationService: service,
            historyStore: historyStore,
            imageCache: cache
        )
    }
}
