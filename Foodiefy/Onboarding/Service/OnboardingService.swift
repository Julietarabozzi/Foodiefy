import Foundation

struct OnboardingService {
    static let shared = OnboardingService()
    private let baseURL = "https://foodiefy-backend-production.up.railway.app/api/onboarding"

    struct OnboardingData: Codable {
        let age: Int
        let weight: Double
        let height: Double
        let goals: String
        let dietaryPreferences: [String]
        let activityLevel: String
    }

    func saveOnboardingData(_ data: OnboardingData, token: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        request.httpBody = try? JSONEncoder().encode(data)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"])))
                return
            }

            do {
                let responseDict = try JSONDecoder().decode([String: String].self, from: data)
                if let message = responseDict["message"] {
                    print("📡 Respuesta del backend (Onboarding): \(responseDict)")
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Respuesta inválida"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension OnboardingService {
    func updateOnboardingData(_ data: OnboardingData, token: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"  // 🆕 Ahora hacemos una actualización
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        request.httpBody = try? JSONEncoder().encode(data)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"])))
                return
            }

            do {
                let responseDict = try JSONDecoder().decode([String: String].self, from: data)
                if let message = responseDict["message"] {
                    print("📡 Respuesta del backend (Actualización Onboarding): \(responseDict)")
                    completion(.success(message))
                } else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Respuesta inválida"])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
