import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)
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
                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("Iniciar sesión")
                        }
                        .buttonStyle(FoodiefyButtonStyle())
                    }
                    
                    Spacer()
                }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet"))) // Aquí aplicamos el modificador
            .navigationDestination(isPresented: $viewModel.loginSuccess) {
                TabBarView()
            }
            .navigationBarHidden(true)
        }
    }
}
