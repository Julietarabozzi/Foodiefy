import SwiftUI

struct PasswordRecoveryView: View {
    @State private var email: String = ""
    @State private var verificationCode: String = ""
    @State private var newPassword: String = ""
    @State private var step: RecoveryStep = .enterEmail
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(step.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("darkGreenFoodiefy"))
            
            Text(step.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            switch step {
            case .enterEmail:
                TextField("Correo electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
            
            case .enterCode:
                TextField("Código de verificación", text: $verificationCode)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
            
            case .resetPassword:
                SecureField("Nueva contraseña", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 40)
            }
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 5)
            }
            
            Button(step.buttonText) {
                handleAction()
            }
            .buttonStyle(FoodiefyButtonStyle())
            .disabled(!isValidInput())
            .opacity(isValidInput() ? 1 : 0.5)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
        .navigationBarBackButtonHidden(true)
    }
    
    private func handleAction() {
        switch step {
        case .enterEmail:
            requestRecoveryCode()
        case .enterCode:
            verifyRecoveryCode()
        case .resetPassword:
            resetPassword()
        }
    }
    
    private func requestRecoveryCode() {
        RecoveryService.shared.requestRecoveryCode(email: email) { success, message in
            DispatchQueue.main.async {
                if success {
                    step = .enterCode
                } else {
                    errorMessage = message
                }
            }
        }
    }
    
    private func verifyRecoveryCode() {
        RecoveryService.shared.verifyRecoveryCode(email: email, code: verificationCode) { success, message in
            DispatchQueue.main.async {
                if success {
                    step = .resetPassword
                } else {
                    errorMessage = message
                }
            }
        }
    }
    
    private func resetPassword() {
        RecoveryService.shared.resetPassword(email: email, code: verificationCode, newPassword: newPassword) { success, message in
            DispatchQueue.main.async {
                if success {
                    step = .enterEmail
                    errorMessage = "Contraseña restablecida con éxito."
                } else {
                    errorMessage = message
                }
            }
        }
    }
    
    private func isValidInput() -> Bool {
        switch step {
        case .enterEmail:
            return !email.isEmpty
        case .enterCode:
            return !verificationCode.isEmpty
        case .resetPassword:
            return newPassword.count >= 8
        }
    }
}

enum RecoveryStep {
    case enterEmail, enterCode, resetPassword
    
    var title: String {
        switch self {
        case .enterEmail: return "Recuperar Contraseña"
        case .enterCode: return "Verificación de Código"
        case .resetPassword: return "Nueva Contraseña"
        }
    }
    
    var description: String {
        switch self {
        case .enterEmail: return "Ingresa tu correo electrónico para recibir un código de recuperación."
        case .enterCode: return "Ingresa el código de verificación enviado a tu correo."
        case .resetPassword: return "Ingresa tu nueva contraseña."
        }
    }
    
    var buttonText: String {
        switch self {
        case .enterEmail: return "Enviar Código"
        case .enterCode: return "Verificar Código"
        case .resetPassword: return "Restablecer Contraseña"
        }
    }
}

class RecoveryService {
    static let shared = RecoveryService()
    private let baseURL = "https://foodiefy-backend-production.up.railway.app/api/auth/recover"

    func requestRecoveryCode(email: String, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "\(baseURL)/request-code")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["email": email], options: [])
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                completion(true, nil)
            }
        }.resume()
    }

    func verifyRecoveryCode(email: String, code: String, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "\(baseURL)/verify-code")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["email": email, "code": code], options: [])
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                completion(true, nil)
            }
        }.resume()
    }
    
    func resetPassword(email: String, code: String, newPassword: String, completion: @escaping (Bool, String?) -> Void) {
        let url = URL(string: "\(baseURL)/reset-password")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["email": email, "code": code, "newPassword": newPassword], options: [])
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, error.localizedDescription)
                    return
                }
                completion(true, nil)
            }
        }.resume()
    }
}

