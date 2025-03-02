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
        guard let url = URL(string: "\(baseURL)/update") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"  // ✅ Cambio a `PUT`
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        do {
            request.httpBody = try JSONEncoder().encode(data)
            print("📡 Enviando request al backend:", String(data: request.httpBody!, encoding: .utf8) ?? "No se pudo convertir a JSON")
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("❌ Error en la request:", error.localizedDescription)
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("❌ No se recibieron datos del backend")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibieron datos"])))
                return
            }

            do {
                let responseDict = try JSONDecoder().decode([String: String].self, from: data)
                if let message = responseDict["message"] {
                    print("✅ Respuesta del backend (Actualización Onboarding): \(responseDict)")
                    completion(.success(message))
                } else {
                    print("❌ Respuesta inválida del backend:", responseDict)
                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Respuesta inválida"])))
                }
            } catch {
                print("❌ Error al decodificar la respuesta:", error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
}
