import Foundation

// 📅 Modelo para representar cada semana del plan
struct WeeklyMealPlan: Identifiable {
    let id = UUID()
    let startDate: String
    let endDate: String
    let meals: String
}

class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var activityLevel: String = ""
    @Published var dietaryPreferences: [String] = []
    @Published var goals: String = ""
    @Published var mealPlan: String = ""
    @Published var isSubmitting = false

    // 🔹 Agregamos esta propiedad para manejar múltiples semanas
    @Published var weeklyPlans: [WeeklyMealPlan] = []

    func sendDataToBackend(completion: @escaping (Bool) -> Void) {
        let userData: [String: Any] = [
            "name": name,
            "age": age,
            "weight": weight,
            "height": height,
            "goals": goals,
            "dietaryPreferences": dietaryPreferences,
            "activityLevel": activityLevel
        ]
        
        isSubmitting = true

        MealPlanService.shared.generateMealPlan(userData) { success, mealPlan in
            DispatchQueue.main.async {
                self.isSubmitting = false
                if success {
                    let newPlan = WeeklyMealPlan(
                        startDate: self.getStartDate(),
                        endDate: self.getEndDate(),
                        meals: mealPlan ?? "No recibido"
                    )
                    self.weeklyPlans.append(newPlan)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }

    // 🔹 Métodos para calcular la fecha de inicio y fin
    private func getStartDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        return formatter.string(from: Date())
    }

    private func getEndDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        guard let nextWeek = Calendar.current.date(byAdding: .day, value: 6, to: Date()) else { return "??/??" }
        return formatter.string(from: nextWeek)
    }
}
