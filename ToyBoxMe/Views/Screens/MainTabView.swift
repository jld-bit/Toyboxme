import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var container: AppContainer

    var body: some View {
        TabView {
            BuilderScreen(viewModel: .init(generationService: container.generationService, historyStore: container.historyStore))
                .tabItem { Label("Create", systemImage: "wand.and.stars") }

            HistoryScreen(viewModel: .init(historyStore: container.historyStore))
                .tabItem { Label("History", systemImage: "clock.arrow.circlepath") }

            SettingsScreen()
                .tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(.pink)
    }
}
