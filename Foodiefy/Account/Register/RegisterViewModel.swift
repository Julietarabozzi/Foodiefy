//
//  File.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 09/02/2025.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading: Bool = false
    @Published var registrationSuccess: Bool = false
    
    func register() {
        guard password == confirmPassword else {
            print("❌ Las contraseñas no coinciden")
            return
        }
        
        isLoading = true
        APIService.shared.registerUser(name: "Nuevo Usuario", email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let message):
                    print("✅ Registro exitoso: \(message)")
                    self?.registrationSuccess = true
                case .failure(let error):
                    print("❌ Error en el registro: \(error.localizedDescription)")
                }
            }
        }
    }
}
