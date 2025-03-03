import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        ScrollView{
            VStack(spacing: 10) {
                Text("Crear cuenta")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkGreenFoodiefy"))
                    .padding(.top)
                
                Text("Regístrate y comienza a alcanzar tus metas")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Image(.foodiefyIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                VStack(spacing: 15) {
                    FoodiefyTextField(placeholder: "Nombre", text: $viewModel.name)
                    FoodiefyTextField(placeholder: "Correo electrónico", text: $viewModel.email)
                    
                    // 🔹 Campo de contraseña con validación
                    FoodiefyPasswordField(placeholder: "Contraseña", text: $viewModel.password)
                        .padding(.bottom)
                    
                    // 🔹 Validaciones de contraseña en tiempo real (Organizado en HStack)
                    VStack(spacing: 5) {
                        HStack(spacing: 15) {
                            passwordRuleView(for: viewModel.passwordCriteria[0])
                            Spacer()
                            
                            passwordRuleView(for: viewModel.passwordCriteria[1])
                                .padding(.leading, -20)
                            Spacer()
                        }
                        
                        HStack(spacing: 15) {
                            passwordRuleView(for: viewModel.passwordCriteria[2])
                            Spacer()
                            passwordRuleView(for: viewModel.passwordCriteria[3])
                        }
                    }
                    .padding(.horizontal)
                }
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .padding(.top, 5)
                }
                
                if viewModel.isLoading {
                    ProgressView().padding()
                } else {
                    Button("Registrarse") {
                        viewModel.register(sessionManager: sessionManager) { success in
                            if success {
                                DispatchQueue.main.async {
                                    router.navigate(to: .onboarding)
                                }
                            }
                        }
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .disabled(!viewModel.isPasswordValid)
                    .padding(.top)
                }
                
                Spacer()
            }
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
        .navigationBarBackButtonHidden(true)
    }
    
    // 🔹 Extraer la vista de cada regla de contraseña en un @ViewBuilder
    @ViewBuilder
    private func passwordRuleView(for rule: PasswordRule) -> some View {
        HStack {
            Image(systemName: rule.isMet ? "checkmark.circle.fill" : "checkmark.circle.fill")
                .foregroundColor(rule.isMet ? .green : .gray)
            Text(rule.text)
                .font(.footnote)
                .foregroundColor(rule.isMet ? .green : .gray)
        }
    }
}
