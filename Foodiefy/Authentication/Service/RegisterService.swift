import Foundation

struct RegisterService {
    static let shared = RegisterService()

    private let baseURL = "https://foodiefy-backend-production.up.railway.app/api/auth"

    struct RegisterResponse: Codable {
        let message: String
        let token: String?
        let userId: String?
    }

    func registerUser(name: String, email: String, password: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["name": name, "email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

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
                let decodedResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                if let token = decodedResponse.token, let userId = decodedResponse.userId {
                    completion(.success(RegisterResponse(message: decodedResponse.message, token: token, userId: userId)))
                } else {
                    completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: decodedResponse.message])))
                }
            } catch {
                let errorMessage = (try? JSONDecoder().decode([String: String].self, from: data))?["message"] ?? "Error desconocido"
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
        }.resume()
    }
}
