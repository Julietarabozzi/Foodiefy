import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var mealPlanViewModel: MealPlanViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    @State private var retryCount = 0
    private let maxRetries = 10

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("Preparando tu experiencia personalizada...")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()

            ProgressView()
                .padding()

            if retryCount >= maxRetries {
                Text("⚠️ No se pudo obtener el plan alimenticio. Intenta más tarde.")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }

            Spacer()
        }
        .onAppear {
            fetchWithRetries()
        }
        .padding()
    }

    private func fetchWithRetries() {
        mealPlanViewModel.fetchMealPlans(sessionManager: sessionManager)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if mealPlanViewModel.mealPlans.isEmpty && retryCount < maxRetries {
                retryCount += 1
                print("📡 Intento \(retryCount) de \(maxRetries) para obtener planes alimenticios...")
                fetchWithRetries()
            } else if !mealPlanViewModel.mealPlans.isEmpty {
                print("✅ Planes alimenticios encontrados, navegando a Home...")
                router.navigate(to: .home)
            }
        }
    }
}
