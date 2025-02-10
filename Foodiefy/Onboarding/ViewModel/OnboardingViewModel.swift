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

    func sendDataToBackend(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:5001/api/onboarding") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "name": name,
            "age": age,
            "weight": weight,
            "height": height,
            "goals": goals,
            "dietaryPreferences": dietaryPreferences,
            "activityLevel": activityLevel
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("❌ Error al enviar los datos: \(error.localizedDescription)")
                    completion(false)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("❌ Respuesta inválida del servidor.")
                    completion(false)
                    return
                }

                print("✅ Datos enviados con éxito.")
                completion(true)
            }
        }.resume()
    }

}
