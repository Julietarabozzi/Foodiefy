import Foundation

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = "" {
        didSet { validateEmail() }
    }
    @Published var password: String = "" {
        didSet { validatePassword() }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var passwordCriteria: [PasswordRule] = [
        .init(text: "Mín 8 caracteres"),
        .init(text: "Mín 1 mayúscula"),
        .init(text: "Mín 1 número"),
        .init(text: "Mín 1 carácter especial")
    ]
    
    func validateEmail() {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        isEmailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func validatePassword() {
        passwordCriteria[0].isMet = password.count >= 8
        passwordCriteria[1].isMet = password.range(of: "[A-Z]", options: .regularExpression) != nil
        passwordCriteria[2].isMet = password.range(of: "[0-9]", options: .regularExpression) != nil
        passwordCriteria[3].isMet = password.range(of: "[!@#$%^&*]", options: .regularExpression) != nil
        
        isPasswordValid = passwordCriteria.allSatisfy { $0.isMet }
    }
    
    var isFormValid: Bool {
        return !name.isEmpty && isEmailValid && isPasswordValid
    }
    
    func register(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            completion(false)
            return
        }
        
        guard isEmailValid, isPasswordValid else {
            completion(false)
            return
        }
        
        isLoading = true

        RegisterService.shared.registerUser(name: name, email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    if let token = response.token, let userId = response.userId {
                        sessionManager.login(name: self?.name ?? "Usuario", email: self?.email ?? "", token: token, userId: userId)
                        self?.requestVerificationCode { success in
                            if success {
                                completion(true)
                            } else {
                                self?.errorMessage = "No se pudo enviar el código de verificación."
                                completion(false)
                            }
                        }
                    } else {
                        self?.errorMessage = "Error inesperado al registrar el usuario."
                        completion(false)
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    private func requestVerificationCode(completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty else {
            print("❌ Error: El email está vacío")
            completion(false)
            return
        }

        let url = URL(string: "https://foodiefy-backend-production.up.railway.app/api/auth/register/request-code")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false)
                    return
                }

                guard let data = data else {
                    completion(false)
                    return
                }

                if let jsonResponse = try? JSONDecoder().decode([String: String].self, from: data),
                   jsonResponse["message"] == "Código enviado exitosamente" {
                    print("✅ Código enviado correctamente")
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }.resume()
    }
}
struct PasswordRule {
    let text: String
    var isMet: Bool = false
}
