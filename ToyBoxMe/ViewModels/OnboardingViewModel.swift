import Foundation

@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var currentPage: Int = 0
    @Published var hasCompletedOnboarding: Bool

    init(hasCompletedOnboarding: Bool) {
        self.hasCompletedOnboarding = hasCompletedOnboarding
    }

    func next(totalPages: Int) {
        if currentPage < totalPages - 1 {
            currentPage += 1
        } else {
            hasCompletedOnboarding = true
        }
    }
}
