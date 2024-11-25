import SwiftUI

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var navigateToOnboarding = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // Título de la pantalla
                    Text("Crear cuenta")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    // Subtítulo de la pantalla
                    Text("Regístrate y comienza a alcanzar tus metas")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()
                    Image(.image)
                    Spacer()

                    // Campo de texto para el correo electrónico
                    TextField("Correo electrónico", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(.horizontal, 40)

                    // Campo de texto para la contraseña
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 40)

                    // Campo de texto para confirmar contraseña
                    SecureField("Confirmar contraseña", text: $confirmPassword)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 40)

                    // Botón para completar el registro
                    Button(action: {
                        if password == confirmPassword {
                            navigateToOnboarding = true
                        } else {
                            print("Las contraseñas no coinciden")
                        }
                    }) {
                        Text("Registrarse")
                    }
                    .buttonStyle(FoodiefyButtonStyle())

                    Spacer()
                }
                .navigationDestination(isPresented: $navigateToOnboarding) {
                    OnboardingWelcomeView()
                }
            }
        }
    }
}

