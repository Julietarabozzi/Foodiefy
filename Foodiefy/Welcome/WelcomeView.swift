import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack {
                header
            
            Image(.foodiefyIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-15))
                .offset(y: 50)
                .padding(.bottom, 32)
            
            WelcomeButtons
           
            }
        .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
     private var header: some View {
         VStack(spacing: 8) {
             Text("Bienvenido")
                 .font(.headline)
                 .foregroundColor(.secondary)

             Text("Foodiefy")
                 .font(.system(size: 36, weight: .bold, design: .rounded))
                 .foregroundColor(Color("darkGreenFoodiefy"))

             Text("Diseña tu alimentación, alcanza tus metas")
                 .font(.system(size: 16, weight: .medium, design: .rounded))
                 .foregroundColor(.gray)
                 .multilineTextAlignment(.center)
                 .padding(.horizontal, 40)
         }
         .padding(.top)
     }
    
    @ViewBuilder
    private var WelcomeButtons: some View {
        Button("Inicia sesión") {
            router.navigate(to: .login)
        }
        .buttonStyle(FoodiefyButtonStyle())
        .padding(.top, 64)

        Button("Crea tu cuenta") {
            router.navigate(to: .register)
        }
        .buttonStyle(FoodiefyButtonStyle())
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}


