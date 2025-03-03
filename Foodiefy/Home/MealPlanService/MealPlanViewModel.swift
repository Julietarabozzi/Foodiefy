import Foundation
import SwiftUI

class MealPlanViewModel: ObservableObject {
    @Published var mealPlans: [MealPlanService.MealPlanResponse] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchMealPlans(sessionManager: UserSessionManager) {
        guard let token = sessionManager.token else {
            errorMessage = "No hay token disponible"
            return
        }

        isLoading = true
        mealPlans = []

        MealPlanService.shared.fetchMealPlans(token: token) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let plans):
                    self?.mealPlans = plans
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
