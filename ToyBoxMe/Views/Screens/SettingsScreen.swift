import SwiftUI

struct SettingsScreen: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            List {
                Section("Privacy") {
                    Text("Selfies and generation history are stored on-device unless your selected API provider requires upload for generation.")
                        .font(.footnote)
                }

                Section("Permissions") {
                    Text("Photos access is requested only when selecting a selfie or saving generated images.")
                        .font(.footnote)
                }

                Section("Support") {
                    Button("Open Apple Privacy Guidance") {
                        guard let url = URL(string: "https://www.apple.com/legal/privacy/") else { return }
                        openURL(url)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
