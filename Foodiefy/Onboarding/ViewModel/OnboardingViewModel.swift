import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var activityLevel: String = ""
    @Published var dietaryPreferences: [String] = []
    @Published var goals: String = ""
    @Published var isSubmitting = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    func sendDataToBackend(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard let token = sessionManager.token else {
            errorMessage = "No hay token disponible"
            completion(false)
            return
        }

        let onboardingData = OnboardingService.OnboardingData(
            age: Int(age) ?? 0,
            weight: Double(weight) ?? 0.0,
            height: Double(height) ?? 0.0,
            goals: goals,
            dietaryPreferences: dietaryPreferences,
            activityLevel: activityLevel
        )

        isSubmitting = true
        isLoading = true
        print("🚀 Enviando datos de onboarding al backend...")

        OnboardingService.shared.saveOnboardingData(onboardingData, token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isSubmitting = false
                self?.isLoading = false
                switch result {
                case .success(let message):
                    print("✅ Onboarding guardado: \(message)")
                    completion(true) // 🔹 Ahora solo confirmamos que los datos se guardaron
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error en onboarding: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
