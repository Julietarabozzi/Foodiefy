import SwiftUI

struct RootView: View {
    @EnvironmentObject var sessionManager: UserSessionManager
    @EnvironmentObject var router: AppRouter

    var body: some View {
        NavigationStack(path: $router.path) {
            contentView
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                    case .register:
                        RegisterView()
                    case .onboarding:
                        OnboardingWelcomeView()
                    case .home:
                        TabBarView()
                    case .onboardingForm:
                        OnboardingFormView()
                    case .goalsForm:
                        GoalsFormView()
                    case .dietaryPreferences:
                        DietaryPreferencesView()
                    case .activityLevel:
                        ActivityLevelView()
                    case .summary:
                        SummaryView()
                    case .loading:
                        LoadingView()
                    case .verification(let isLogin):
                        VerificationCodeView(isLogin: isLogin) 
                    }
                }
        }
        .onChange(of: sessionManager.isLoggedIn) { oldValue, newValue in
            if !newValue {
                router.reset()
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if sessionManager.isLoggedIn {
            TabBarView()
        } else {
            WelcomeView()
        }
    }
}
