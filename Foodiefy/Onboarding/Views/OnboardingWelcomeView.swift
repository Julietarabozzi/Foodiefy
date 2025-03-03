import SwiftUI

struct OnboardingWelcomeView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()
                
                // Título
                Text("¡Bienvenido a Foodiefy!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkGreenFoodiefy"))
                
                // Subtítulo
                Text("Diseña tu alimentación y alcanza tus metas. Estamos aquí para ayudarte a construir una vida más saludable.")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                // Imagen central
                Image(.foodiefyIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Spacer()
                
                // Botón para comenzar
                Button(action: {
                    router.navigate(to: .onboardingForm)
                }) {
                    Text("Comenzar")
                }
                .buttonStyle(FoodiefyButtonStyle())
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .padding(.vertical, 40)
        }
        .modifier(NavigationBackModifier(color: Color("darkViolet"))) // Aquí aplicamos el modificador
        .navigationBarHidden(true)
    }
}

// Preview
struct OnboardingWelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingWelcomeView()
            .environmentObject(AppRouter())
    }
}
