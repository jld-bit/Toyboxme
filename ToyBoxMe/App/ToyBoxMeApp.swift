import SwiftUI

@main
struct ToyBoxMeApp: App {
    @StateObject private var appContainer = AppContainer.makeDefault()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appContainer)
                .preferredColorScheme(.light)
        }
    }
}
