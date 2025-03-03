import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = "" {
        didSet { validatePassword() } // 🔹 Se validará en tiempo real
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    // 🔹 Reglas de validación de contraseña
    @Published var isPasswordValid: Bool = false
    @Published var passwordCriteria: [PasswordRule] = [
        .init(text: "Mín 8 caracteres"),
        .init(text: "Mín 1 mayúscula"),
        .init(text: "Mín 1 número"),
        .init(text: "Mín 1 carácter especial")
    ]

    func validatePassword() {
        passwordCriteria[0].isMet = password.count >= 8
        passwordCriteria[1].isMet = password.range(of: "[A-Z]", options: .regularExpression) != nil
        passwordCriteria[2].isMet = password.range(of: "[0-9]", options: .regularExpression) != nil
        passwordCriteria[3].isMet = password.range(of: "[!@#$%^&*]", options: .regularExpression) != nil
        
        isPasswordValid = passwordCriteria.allSatisfy { $0.isMet }
    }

    func register(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "Todos los campos son obligatorios"
            completion(false)
            return
        }

        guard isPasswordValid else {
            errorMessage = "La contraseña no cumple con los requisitos"
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
                        sessionManager.token = token
                        sessionManager.userId = userId
                        sessionManager.login(name: self?.name ?? "Usuario", token: token, userId: userId)
                        completion(true)
                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}

// 🔹 Modelo para representar cada regla de la contraseña
struct PasswordRule {
    let text: String
    var isMet: Bool = false
}
