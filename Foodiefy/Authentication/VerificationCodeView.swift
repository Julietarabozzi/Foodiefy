import SwiftUI

struct VerificationCodeView: View {
    var isLogin: Bool
    
    @State private var verificationCode: String = ""
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text(isLogin ? "Verificación de Inicio de Sesión" : "Verificación de Cuenta")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("darkGreenFoodiefy"))
            
            Text("Ingresa el código de verificación que enviamos a tu correo electrónico.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            TextField("Código de verificación", text: $verificationCode)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 5)
            }
            
            Button("Confirmar") {
                verifyCode()
            }
            .buttonStyle(FoodiefyButtonStyle())
            .disabled(verificationCode.isEmpty)
            .opacity(verificationCode.isEmpty ? 0.5 : 1)
            .padding(.horizontal, 40)
            
            Spacer()
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
        .navigationBarBackButtonHidden(true)
    }
    private func verifyCode() {
        guard let userEmail = sessionManager.userEmail, !userEmail.isEmpty else {
            errorMessage = "No se encontró un email registrado. Intenta de nuevo."

            return
        }
        
        let url = URL(string: "https://foodiefy-backend-production.up.railway.app/api/auth/login/verify-code")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": userEmail, "code": verificationCode]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = "Error de red: \(error.localizedDescription)"
                    return
                }
                
                guard let data = data else {
                    print("❌ No se recibió respuesta del servidor")
                    self.errorMessage = "Error de conexión. Intenta nuevamente."
                    return
                }
                
                if let jsonResponse = try? JSONDecoder().decode([String: String].self, from: data),
                   let token = jsonResponse["token"] {
                    
                    sessionManager.token = token
                    sessionManager.isLoggedIn = true
                    
                    router.navigate(to: .home)
                } else {
                    self.errorMessage = "Código incorrecto. Inténtalo nuevamente."
                }
            }
        }.resume()
    }
}
