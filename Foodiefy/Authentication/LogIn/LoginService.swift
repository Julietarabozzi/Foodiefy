import Foundation

struct LoginService {
    static let shared = LoginService()

    private let baseURL = "https://foodiefy-backend-production.up.railway.app/api/auth"

    struct LoginResponse: Codable {
        let token: String?
        let user: UserResponse?
    }

    struct UserResponse: Codable {
        let id: String
        let name: String
        let email: String
    }

    func requestLoginCode(email: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login/request-code") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email]
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

            if let jsonResponse = try? JSONDecoder().decode([String: String].self, from: data),
               let message = jsonResponse["message"] {
                completion(.success(message))
            } else {
                let errorMessage = "Error desconocido al solicitar el código"
                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: errorMessage])))
            }
        }.resume()
    }
    func verifyLoginCode(email: String, code: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login/verify-code") else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email, "code": code]
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
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])

                let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {

                if let errorResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                }

                completion(.failure(NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Error al verificar código"])))
            }
        }.resume()
    }
}
