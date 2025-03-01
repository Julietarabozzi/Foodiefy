import Foundation
import SwiftUI

class MealPlanViewModel: ObservableObject {
    @Published var mealPlans: [MealPlanService.MealPlanResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    // 🔹 Obtener todos los planes alimenticios
    func fetchMealPlans(sessionManager: UserSessionManager) {
        guard let token = sessionManager.token else {
            errorMessage = "No hay token disponible"
            return
        }

        isLoading = true
        mealPlans = [] // 🔹 Limpiar antes de hacer la nueva solicitud
        print("📡 Cargando planes alimenticios...")

        MealPlanService.shared.fetchMealPlans(token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let plans):
                    self?.mealPlans = plans
                    print("✅ Planes alimenticios cargados.")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error al obtener planes: \(error.localizedDescription)")
                }
            }
        }
    }
}
