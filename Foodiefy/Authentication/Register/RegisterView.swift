import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                header
                
                FormFieldsView(viewModel: viewModel)
                
                if let errorMessage = viewModel.errorMessage {
                    ErrorMessageView(errorMessage: errorMessage)
                }
                if viewModel.isLoading {
                    ProgressView().padding()
                } else {
                    RegisterButtonView(viewModel: viewModel)
                        .environmentObject(router)
                        .environmentObject(sessionManager)
                }
                Spacer()
            }
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color(.darkViolet)))
        .navigationBarBackButtonHidden(true)
    }
}

@ViewBuilder
private var header: some View {
    VStack(spacing: 10) {
        Text("Crear cuenta")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color(.darkGreenFoodiefy))
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
    }
}

private struct FormFieldsView: View {
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            FoodiefyTextField(placeholder: "Nombre", text: $viewModel.name)
            FoodiefyTextField(placeholder: "Correo electrónico", text: $viewModel.email)
            FoodiefyPasswordField(placeholder: "Contraseña", text: $viewModel.password)
                .padding(.bottom)
            
            PasswordValidationView(viewModel: viewModel)
        }
    }
}

private struct PasswordValidationView: View {
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 15) {
                passwordRuleView(for: viewModel.passwordCriteria[0])
                Spacer()
                passwordRuleView(for: viewModel.passwordCriteria[1])
                    .padding(.leading, -22)
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
    
    @ViewBuilder
    private func passwordRuleView(for rule: PasswordRule) -> some View {
        HStack {
            Image(systemName: rule.isMet ? "checkmark.circle.fill" : "checkmark.circle.fill" )
                .foregroundColor(rule.isMet ? .darkGreenFoodiefy : .gray)
            Text(rule.text)
                .font(.footnote)
                .foregroundColor(rule.isMet ? .darkGreenFoodiefy : .gray)
        }
    }
}

private struct RegisterButtonView: View {
    @ObservedObject var viewModel: RegisterViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager
    
    var body: some View {
        Button("Registrarse") {
            viewModel.register(sessionManager: sessionManager) { success in
                if success {
                    DispatchQueue.main.async {
                        router.navigate(to: .verification) 
                    }
                }
            }
        }
        .buttonStyle(FoodiefyButtonStyle())
        .disabled(!viewModel.isFormValid)
        .opacity(viewModel.isFormValid ? 1 : 0.5)
        .padding(.top)
    }
}

private struct ErrorMessageView: View {
    let errorMessage: String
    
    var body: some View {
        Text(errorMessage)
            .foregroundColor(.red)
            .font(.footnote)
            .padding(.top, 5)
    }
}
