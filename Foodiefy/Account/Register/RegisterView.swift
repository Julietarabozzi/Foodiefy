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
                        .foregroundColor(.primary)

                    Text("Regístrate y comienza a alcanzar tus metas")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()
                    Image("image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                    Spacer()

                    TextField("Correo electrónico", text: $viewModel.email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 40)

                    TextField("Contraseña", text: $viewModel.password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 40)

                    TextField("Confirmar contraseña", text: $viewModel.confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 40)

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
            }
        }
    }
}
