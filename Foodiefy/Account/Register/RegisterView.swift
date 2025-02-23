import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)
                
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
                    
                    Spacer()
                    Image("image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    Spacer()
                    
                    // Campos de texto reutilizables
                    VStack(spacing: 15) {
                        FoodiefyTextField(placeholder: "Correo electrónico", text: $viewModel.email)
                        FoodiefyPasswordField(placeholder: "Contraseña", text: $viewModel.password)
                        FoodiefyPasswordField(placeholder: "Confirmar contraseña", text: $viewModel.confirmPassword)
                            .textContentType(.none)
                    }
                    
                    if viewModel.isLoading {
                        ProgressView().padding()
                    } else {
                        Button(action: {
                            viewModel.register()
                        }) {
                            Text("Registrarse")
                        }
                        .buttonStyle(FoodiefyButtonStyle())
                    }
                    
                    Spacer()
                }
                .navigationDestination(isPresented: $viewModel.registrationSuccess) {
                    OnboardingWelcomeView()
                }
                .modifier(NavigationBackModifier(color: Color("darkViolet"))) // Aquí aplicamos el modificador
                .navigationBarHidden(true)
            }
        }
    }
}
