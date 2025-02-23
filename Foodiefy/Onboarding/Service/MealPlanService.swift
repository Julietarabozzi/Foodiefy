//
//  OnboardingService.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 21/02/2025.
//
import Foundation

class MealPlanService {
    static let shared = MealPlanService()
    private let baseURL = "https://foodiefy-backend-production.up.railway.app/api/meal-plan"

    func generateMealPlan(_ userData: [String: Any], completion: @escaping (Bool, String?) -> Void) {
        guard let url = URL(string: baseURL) else {
            print("❌ URL inválida")
            completion(false, "URL inválida")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: userData, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Error en la solicitud: \(error.localizedDescription)")
                    completion(false, error.localizedDescription)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("❌ Respuesta inválida del servidor")
                    completion(false, "Respuesta inválida")
                    return
                }

                if let data = data, let decodedResponse = try? JSONDecoder().decode(MealPlanResponse.self, from: data) {
                    print("✅ Plan alimenticio recibido del backend")
                    completion(true, decodedResponse.mealPlan)
                } else {
                    completion(false, "Error al decodificar la respuesta")
                }
            }
        }.resume()
    }
}

// Modelo para recibir la respuesta del backend
struct MealPlanResponse: Codable {
    let message: String
    let mealPlan: String
}
