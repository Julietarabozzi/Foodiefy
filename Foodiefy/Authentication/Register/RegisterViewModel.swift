import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func register(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "Todos los campos son obligatorios"
            completion(false)
            return
        }

        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"
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
                        sessionManager.login()

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
