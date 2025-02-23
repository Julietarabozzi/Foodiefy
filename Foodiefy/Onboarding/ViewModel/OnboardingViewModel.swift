import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var activityLevel: String = ""
    @Published var dietaryPreferences: [String] = []
    @Published var goals: String = ""
    @Published var mealPlan: String = "" // 🔹 Aquí guardamos el plan generado
    @Published var isSubmitting = false // 🔹 Para mostrar un indicador de carga

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
        
        isSubmitting = true // 🔹 Comienza la carga

        OnboardingService.shared.generateMealPlan(userData) { success, mealPlan in
            DispatchQueue.main.async {
                self.isSubmitting = false // 🔹 Finaliza la carga
                if success {
                    self.mealPlan = mealPlan ?? "No recibido"
                    print("✅ Plan generado:\n\(self.mealPlan)")
                    completion(true)
                } else {
                    print("❌ Error al generar el plan: \(mealPlan ?? "Desconocido")")
                    completion(false)
                }
            }
        }
    }
}
