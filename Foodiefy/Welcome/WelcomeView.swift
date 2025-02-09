import SwiftUI

struct WelcomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                VStack(spacing: 8) {
                    Text("Foodify")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(Color("darkGreenFoodiefy"))
                    
                    Text("Diseña tu alimentación, alcanza tus metas")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                
                // Imagen del logo
                Image("image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Spacer()
                
                // Botones estilizados
                VStack(spacing: 15) {
                    NavigationLink(destination: LoginView()) {
                        Text("Inicia sesión")
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Crea tu cuenta")
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                }
                
                Spacer()
            }
            .padding(.vertical, 40)
        }
    }
    
}

// Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


