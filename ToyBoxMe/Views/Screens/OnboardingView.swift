import SwiftUI

struct OnboardingView: View {
    let completion: () -> Void

    private let pages: [(String, String, String)] = [
        ("Create Playful Portraits", "Turn a selfie into an original toy-box inspired character package.", "sparkles.rectangle.stack"),
        ("Customize Every Detail", "Pick style, name, accessories, and vibrant packaging colors.", "paintpalette"),
        ("Save & Share", "Keep your generation history private on-device and share your favorites.", "square.and.arrow.up")
    ]

    @StateObject private var viewModel = OnboardingViewModel(hasCompletedOnboarding: false)

    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .pink, .orange], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack(spacing: 18) {
                Spacer()
                Image(systemName: pages[viewModel.currentPage].2)
                    .font(.system(size: 72))
                    .foregroundStyle(.white)
                Text(pages[viewModel.currentPage].0)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                Text(pages[viewModel.currentPage].1)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.horizontal)
                Spacer()

                Button(viewModel.currentPage == pages.count - 1 ? "Get Started" : "Continue") {
                    if viewModel.currentPage == pages.count - 1 {
                        completion()
                    } else {
                        viewModel.next(totalPages: pages.count)
                    }
                }
                .buttonStyle(VibrantButtonStyle())
                .padding()
            }
        }
    }
}
