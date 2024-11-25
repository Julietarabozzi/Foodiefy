import SwiftUI

struct OnboardingWelcomeView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    // Mensaje de bienvenida
                    Text("¡Bienvenido a Foodiefy!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Text("Diseña tu alimentación y alcanza tus metas. Estamos aquí para ayudarte a construir una vida más saludable.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Spacer()
                    Image(.image)
                    Spacer()
                    
                    // Botón para comenzar
                    NavigationLink(destination: OnboardingFormView()) {
                        Text("Comenzar")
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

// Preview para la vista de bienvenida
struct OnboardingWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingWelcomeView()
    }
}

