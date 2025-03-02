import Foundation
import SwiftUI

struct ProgressResponse: Codable {
    struct DayProgress: Codable {
        let day: Int
        let completed: Bool
    }
    let progress: [DayProgress]
}

class ProgressViewModel: ObservableObject {
    @Published var weeklyProgress: [Bool] = Array(repeating: false, count: 7)
    @Published var isLoading = false
    @Published var errorMessage: String?
    private var lastFetchedUserId: String?
    
    func resetProgress() {
        DispatchQueue.main.async {
            self.weeklyProgress = Array(repeating: false, count: 7)
            self.errorMessage = nil
            self.lastFetchedUserId = nil
        }
    }
        
    func fetchProgress(token: String, userId: String) {
        // Evitar recargas innecesarias
        if lastFetchedUserId == userId {
            return
        }

        guard let url = URL(string: "https://foodiefy-backend-production.up.railway.app/api/progress?userId=\(userId)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        isLoading = true
        lastFetchedUserId = userId

        URLSession.shared.dataTask(with: request) { data, _, error in
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
                    let response = try JSONDecoder().decode(ProgressResponse.self, from: data)
                    var newProgress = Array(repeating: false, count: 7)
                    for progress in response.progress {
                        if progress.day >= 1, progress.day <= 7 {
                            newProgress[progress.day - 1] = progress.completed
                        }
                    }
                    self.weeklyProgress = newProgress
                } catch {
                    self.errorMessage = "Error al decodificar respuesta"
                }
            }
        }.resume()
    }

    func updateProgress(day: Int, completed: Bool, token: String, userId: String) {
        guard let url = URL(string: "https://foodiefy-backend-production.up.railway.app/api/progress/update") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let body: [String: Any] = ["userId": userId, "day": day, "completed": completed]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No se recibieron datos"
                    return
                }

                print("✅ Progreso actualizado exitosamente: \(String(data: data, encoding: .utf8) ?? "Sin respuesta")")
            }
        }.resume()
    }
}
