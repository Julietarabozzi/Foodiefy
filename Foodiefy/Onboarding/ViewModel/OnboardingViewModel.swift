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

        OnboardingService.shared.saveOnboardingData(onboardingData, token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isSubmitting = false
                self?.isLoading = false
                switch result {
                case .success(let message):
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}
extension OnboardingViewModel {
    func isFormValid(age: String, weight: String, height: String) -> Bool {
        guard let ageInt = Int(age), let weightDouble = Double(weight), let heightDouble = Double(height) else {
            return false
        }
        
        return (18...100).contains(ageInt) &&
               (35...180).contains(weightDouble) &&
               (100...200).contains(heightDouble)
    }
}
