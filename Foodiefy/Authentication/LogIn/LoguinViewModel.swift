import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = "" {
        didSet { validateForm() }
    }
    @Published var password: String = "" {
        didSet { validateForm() }
    }
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    @Published var isEmailValid: Bool = false
    @Published var isFormValid: Bool = false

    // 📌 Validación de email en tiempo real
    func validateForm() {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        isEmailValid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)

        isFormValid = isEmailValid && !password.isEmpty
    }

    func login(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard isFormValid else {
            completion(false)
            return
        }
        
        isLoading = true

        LoginService.shared.loginUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let response):
                    if let token = response.token, let user = response.user {
                        sessionManager.token = token
                        sessionManager.userId = user.id
                        sessionManager.name = user.name
                        sessionManager.login(name: user.name, token: token, userId: user.id)

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
