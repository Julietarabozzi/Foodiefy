//
//  LoguinViewModel.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 08/02/2025.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var loginSuccess: Bool = false
    
    func login(completion: @escaping (Bool) -> Void) {
        guard !email.isEmpty, !password.isEmpty else {
            print("❌ Los campos están vacíos.")
            completion(false) // Llamamos al callback con `false`
            return
        }
        
        isLoading = true
        APIService.shared.loginUser(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let message):
                    print("✅ Login Success: \(message)")
                    self?.loginSuccess = true
                    completion(true) // Llamamos al callback con `true`
                case .failure(let error):
                    print("❌ Error en el login: \(error.localizedDescription)")
                    completion(false) // Llamamos al callback con `false`
                }
            }
        }
    }
}
