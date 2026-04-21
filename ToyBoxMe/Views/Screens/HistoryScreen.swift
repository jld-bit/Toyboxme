import SwiftUI

struct HistoryScreen: View {
    @StateObject var viewModel: HistoryViewModel

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.records.isEmpty {
                    ContentUnavailableView("No Portraits Yet", systemImage: "shippingbox", description: Text("Generate your first toy-box style portrait."))
                } else {
                    List(viewModel.records) { record in
                        HStack(spacing: 12) {
                            if let image = viewModel.image(for: record) {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 64, height: 64)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            VStack(alignment: .leading) {
                                Text(record.characterName).font(.headline)
                                Text(record.stylePreset.title).font(.subheadline)
                                Text(record.createdAt, style: .date).font(.caption)
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
            .onAppear { viewModel.load() }
        }
    }
}
