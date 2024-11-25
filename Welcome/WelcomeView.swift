import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo que cubre toda el área
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // Logo o imagen de la aplicación
                    Image("image") // Asegúrate de que "image" esté en tus Assets
                        .resizable()
                        .frame(width: 100, height: 100)

                    // Título de la aplicación
                    Text("Foodify")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    // Subtítulo
                    Text("Diseña tu alimentación, alcanza tus metas")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()
                    Image(.image)
                    Spacer()
                    // Botón para iniciar sesión
                    NavigationLink(destination: LoginView()) {
                        Text("Iniciar sesión")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)

                    // Botón para crear cuenta
                    NavigationLink(destination: SignUpView()) {
                        Text("Crear tu cuenta")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)

                    Spacer()
                }
            }
        }
    }
}

// Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


