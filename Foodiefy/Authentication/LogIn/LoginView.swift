import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            header
            
            LoginFieldsView(viewModel: viewModel)
            
            if let errorMessage = viewModel.errorMessage {
                ErrorMessageView(errorMessage: errorMessage)
            }

            if viewModel.isLoading {
                ProgressView().padding()
            } else {
                LoginButtonView(viewModel: viewModel)
                    .environmentObject(router)
                    .environmentObject(sessionManager)
            }

            Spacer()
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color(.darkViolet)))
        .navigationBarBackButtonHidden(true)
    }
}

@ViewBuilder
private var header: some View {
    VStack(spacing: 10) {
        Text("Bienvenido de nuevo")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color(.darkGreenFoodiefy))

        Image(.foodiefyIcon)
            .resizable()
            .scaledToFit()
            .frame(width: 300, height: 300)
    }
}

private struct LoginFieldsView: View {
    @ObservedObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 15) {
            FoodiefyTextField(placeholder: "Correo electrónico", text: $viewModel.email)
            FoodiefyPasswordField(placeholder: "Contraseña", text: $viewModel.password)
        }
    }
}

private struct LoginButtonView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        Button("Iniciar sesión") {
            viewModel.login(sessionManager: sessionManager) { success in
                if success {
                    DispatchQueue.main.async {
                        router.navigate(to: .verification(isLogin: true)) 
                    }
                }
            }
        }
        .buttonStyle(FoodiefyButtonStyle())
        .disabled(!viewModel.isFormValid)
        .opacity(viewModel.isFormValid ? 1 : 0.5) 
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
