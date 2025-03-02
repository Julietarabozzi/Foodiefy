import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var onboardingData = OnboardingState()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func loadProfile(sessionManager: UserSessionManager) {
        guard let token = sessionManager.token else {
            errorMessage = "No hay token disponible"
            return
        }
        
        isLoading = true
        print("📡 Cargando datos del perfil...")

        guard let url = URL(string: "https://foodiefy-backend-production.up.railway.app/api/onboarding") else {
            self.errorMessage = "URL inválida"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No se recibieron datos"
                    return
                }

                do {
                    let response = try JSONDecoder().decode(OnboardingState.self, from: data)
                    self.onboardingData = response
                } catch {
                    self.errorMessage = "Error al decodificar datos"
                }
            }
        }.resume()
    }

    func updateProfile(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard let token = sessionManager.token else {
            errorMessage = "No hay token disponible"
            completion(false)
            return
        }

        let updatedData = OnboardingService.OnboardingData(
            age: onboardingData.age,
            weight: onboardingData.weight,
            height: onboardingData.height,
            goals: onboardingData.goals,
            dietaryPreferences: onboardingData.dietaryPreferences,
            activityLevel: onboardingData.activityLevel
        )

        isLoading = true

        OnboardingService.shared.updateOnboardingData(updatedData, token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let message):
                    print("✅ Perfil actualizado: \(message)")
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error al actualizar perfil: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
