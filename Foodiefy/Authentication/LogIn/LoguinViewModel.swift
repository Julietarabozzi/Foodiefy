import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func login(sessionManager: UserSessionManager, completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Todos los campos son obligatorios"
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
