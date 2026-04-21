import PhotosUI
import SwiftUI

struct BuilderScreen: View {
    @StateObject var viewModel: BuilderViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    FunCard {
                        PhotosPicker(selection: $viewModel.selectedItem, matching: .images) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 220)

                                if let image = viewModel.selfieImage {
                                    Image(uiImage: image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 220)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                } else {
                                    Label("Choose Selfie", systemImage: "person.crop.square")
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .accessibilityLabel("Select a selfie image")
                    }

                    FunCard {
                        TextField("Character Name", text: $viewModel.characterName)
                            .textFieldStyle(.roundedBorder)
                            .accessibilityLabel("Character Name")

                        Picker("Style", selection: $viewModel.selectedPreset) {
                            ForEach(StylePreset.allCases) { preset in
                                Text(preset.title).tag(preset)
                            }
                        }
                        .pickerStyle(.menu)

                        ForEach($viewModel.accessoryLabels) { $label in
                            TextField("Accessory", text: $label.text)
                                .textFieldStyle(.roundedBorder)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(ColorTheme.playfulThemes) { theme in
                                    Button(theme.name) {
                                        viewModel.selectedTheme = theme
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(theme.gradient)
                                    .clipShape(Capsule())
                                    .overlay {
                                        Capsule().stroke(.white.opacity(viewModel.selectedTheme == theme ? 1 : 0.2), lineWidth: 2)
                                    }
                                    .foregroundStyle(.white)
                                }
                            }
                        }
                    }

                    if let generatedImage = viewModel.generatedImage {
                        FunCard {
                            Image(uiImage: generatedImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 16))

                            HStack {
                                Button("Save") { Task { await viewModel.saveToPhotos() } }
                                    .buttonStyle(VibrantButtonStyle())

                                ShareLink(item: Image(uiImage: generatedImage), preview: SharePreview("ToyBox Me Portrait", image: Image(uiImage: generatedImage))) {
                                    Label("Share", systemImage: "square.and.arrow.up")
                                }
                                .buttonStyle(VibrantButtonStyle())
                            }
                        }
                    }

                    Button {
                        Task { await viewModel.generate() }
                    } label: {
                        if viewModel.isGenerating {
                            ProgressView("Generating...")
                                .frame(maxWidth: .infinity)
                        } else {
                            Label("Generate Portrait", systemImage: "sparkles")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .buttonStyle(VibrantButtonStyle())
                    .disabled(viewModel.isGenerating)

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                }
                .padding()
            }
            .background(
                LinearGradient(colors: [Color.pink.opacity(0.35), Color.orange.opacity(0.3), Color.blue.opacity(0.25)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            )
            .navigationTitle("ToyBox Me")
            .task(id: viewModel.selectedItem) {
                await viewModel.loadSelectedImage()
            }
        }
    }
}
