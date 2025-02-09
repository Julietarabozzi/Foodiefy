import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo que cubre toda el área
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    
                    Text("Foodify")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.darkGreenFoodiefy)
                        .padding(.top, 80)

                    // Subtítulo
                    Text("Diseña tu alimentación, alcanza tus metas")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.darkGreenFoodiefy)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                        Image("image")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
            
                    Spacer()
                    // Botón para iniciar sesión
                    NavigationLink(destination: LoginView()) {
                        Text("Inicia sesión")
                    }
                    .buttonStyle(FoodiefyButtonStyle())

                    // Botón para crear cuenta
                    NavigationLink(destination: RegisterView()) {
                        Text("Crea tu cuenta")
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.bottom, 60)
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


