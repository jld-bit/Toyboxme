import SwiftUI

struct RootView: View {
    @EnvironmentObject private var container: AppContainer
    @AppStorage("has_completed_onboarding") private var hasCompletedOnboarding = false

    var body: some View {
        if hasCompletedOnboarding {
            MainTabView()
        } else {
            OnboardingView {
                hasCompletedOnboarding = true
            }
        }
    }
}
