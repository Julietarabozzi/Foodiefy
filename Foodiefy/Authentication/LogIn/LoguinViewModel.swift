import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = "" {
        didSet { validateForm() }
    }
    @Published var password: String = "" {
        didSet { validateForm() }
    }
    @Published var verificationCode: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isEmailValid: Bool = false
    @Published var isFormValid: Bool = false
    @Published var isCodeRequested: Bool = false

    func validateForm() {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        isEmailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        isFormValid = isEmailValid && !password.isEmpty
    }
    
    func requestLoginCode(completion: @escaping (Bool) -> Void) {
        guard isEmailValid else {
            errorMessage = "Correo inválido"
            completion(false)
            return
        }
        
        isLoading = true
        LoginService.shared.requestLoginCode(email: email) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let message):
                    print("📩 Código enviado: \(message)")
                    self?.isCodeRequested = true
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    func verifyLoginCode(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty && !verificationCode.isEmpty else {
            errorMessage = "Código inválido"
            completion(false)
            return
        }

        isLoading = true
        LoginService.shared.verifyLoginCode(email: email, code: verificationCode) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):

                    if let token = response.token, let user = response.user {
                        sessionManager.token = token
                        sessionManager.userId = user.id
                        sessionManager.name = user.name
                        sessionManager.login(name: user.name, email: user.email, token: token, userId: user.id)
                        completion(true)
                    } else {
                        self?.errorMessage = "Código inválido"
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

