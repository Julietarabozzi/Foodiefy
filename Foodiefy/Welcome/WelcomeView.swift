import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
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
            
            Image("image")
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
            
            Spacer()
            
            VStack(spacing: 15) {
                Button("Inicia sesión") {
                    router.navigate(to: .login)
                }
                .buttonStyle(FoodiefyButtonStyle())
                
                Button("Crea tu cuenta") {
                    router.navigate(to: .register)
                }
                .buttonStyle(FoodiefyButtonStyle())
            }
            
            Spacer()
        }
    }
    
}

// Preview
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


