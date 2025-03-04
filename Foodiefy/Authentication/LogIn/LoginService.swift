import Foundation

struct LoginService {
    static let shared = LoginService()

    private let baseURL = "https://foodiefy-backend-production.up.railway.app/api/auth"

    struct LoginResponse: Codable {
        let token: String?
        let user: UserResponse?
        let message: String?
    }

    struct UserResponse: Codable {
        let id: String
        let name: String
        let email: String
    }

    func loginUser(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email, "password": password]
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
                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                let errorMessage = (try? JSONDecoder().decode([String: String].self, from: data))?["message"] ?? "Error desconocido"
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
        }.resume()
    }
}
