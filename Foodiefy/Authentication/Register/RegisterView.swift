import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Crear cuenta")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("darkGreenFoodiefy"))

            Text("Regístrate y comienza a alcanzar tus metas")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Image("image")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)

            VStack(spacing: 15) {
                FoodiefyTextField(placeholder: "Nombre", text: $viewModel.name) // 🔹 Nuevo campo
                FoodiefyTextField(placeholder: "Correo electrónico", text: $viewModel.email)
                FoodiefyPasswordField(placeholder: "Contraseña", text: $viewModel.password)
                FoodiefyPasswordField(placeholder: "Confirmar contraseña", text: $viewModel.confirmPassword)
                    .textContentType(.none)
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
            }
            Spacer()
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
    }
}
