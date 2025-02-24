import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Text("Bienvenido de nuevo")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("darkGreenFoodiefy"))

            Image("image")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)

            VStack(spacing: 15) {
                FoodiefyTextField(placeholder: "Correo electrónico", text: $viewModel.email)
                FoodiefyPasswordField(placeholder: "Contraseña", text: $viewModel.password)
            }

            if viewModel.isLoading {
                ProgressView().padding()
            } else {
                Button("Iniciar sesión") {
                    viewModel.login { success in
                        if success {
                            sessionManager.login()
                            router.navigate(to: .home)
                        }
                    }
                }
                .buttonStyle(FoodiefyButtonStyle())
                .navigationBarHidden(true)
            }
            Spacer()
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
    }
    
}
