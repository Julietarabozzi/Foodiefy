//
//  OnboardingViewModel.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 09/02/2025.
//

import Foundation
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
    @Published var isSubmitting = false

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
        OnboardingService.shared.sendUserData(userData) { success, receivedMealPlan in
            DispatchQueue.main.async {
                self.isSubmitting = false
                if success {
                    self.mealPlan = receivedMealPlan ?? "No se pudo generar un plan."
                }
                completion(success)
            }
        }
    }
}
