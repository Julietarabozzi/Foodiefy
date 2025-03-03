//
//  FoodScannerViewModel.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 02/03/2025.
//

import Foundation
import Foundation

struct EdamamResponse: Codable {
    struct FoodItem: Codable {
        let foodId: String
        let label: String
        let knownAs: String?
        let nutrients: Nutrients
        let category: String
        let categoryLabel: String
        let image: String?
    }

    struct Nutrients: Codable {
        let ENERC_KCAL: Double? // Calorías
        let PROCNT: Double? // Proteínas
        let FAT: Double? // Grasas
        let CHOCDF: Double? // Carbohidratos
        let FIBTG: Double? // Fibra
    }

    let parsed: [ParsedFood]
    let hints: [Hint]

    struct ParsedFood: Codable {
        let food: FoodItem
    }

    struct Hint: Codable {
        let food: FoodItem
    }
}

class FoodScannerViewModel: ObservableObject {
    @Published var foodName: String = ""
    @Published var nutrients: EdamamResponse.Nutrients?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchNutrients(for food: String) {
        isLoading = true

        let appId = APIKeys.edamamAppID
        let appKey = APIKeys.edamamAppKey

        // 🔹 Verificar si las credenciales están bien cargadas
        if appId.isEmpty || appKey.isEmpty {
            self.errorMessage = "❌ Error: API Keys no están configuradas correctamente"
            print("❌ API ID o Key vacíos")
            return
        }

        let query = food.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let urlString = "https://api.edamam.com/api/food-database/v2/parser?ingr=\(query)&app_id=\(appId)&app_key=\(appKey)"

        guard let url = URL(string: urlString) else {
            self.errorMessage = "URL inválida"
            return
        }

        print("🌍 URL Final: \(urlString)") // 🔹 Verificar que la URL está bien construida

        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }
                guard let data = data else {
                    self.errorMessage = "No se recibieron datos"
                    return
                }

                do {
                    let response = try JSONDecoder().decode(EdamamResponse.self, from: data)

                    if let firstFood = response.parsed.first?.food {
                        self.foodName = firstFood.label
                        self.nutrients = firstFood.nutrients
                        print("🍏 Nutrientes obtenidos de `parsed`: \(firstFood.label)")
                    } else if let firstHint = response.hints.first?.food {
                        self.foodName = firstHint.label
                        self.nutrients = firstHint.nutrients
                        print("🍏 Nutrientes obtenidos de `hints`: \(firstHint.label)")
                    } else {
                        self.errorMessage = "No se encontró información nutricional"
                    }

                } catch {
                    self.errorMessage = "Error al decodificar la respuesta: \(error.localizedDescription)"
                    print("❌ Decoding error: \(error)")
                    print("❌ Data recibida: \(String(data: data, encoding: .utf8) ?? "No data")")
                }
            }
        }.resume()
    }
}
