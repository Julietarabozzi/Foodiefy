import SwiftUI

struct OnboardingWelcomeView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()
                OnboardingHeaderView()
                Spacer()
                OnboardingImageView()
                Spacer()
                OnboardingButtonView()
                Spacer()
            }
            .padding(.vertical, 40)
        }
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
        .navigationBarBackButtonHidden(true)
    }
}

private struct OnboardingHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("¡Bienvenido a Foodiefy!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(.darkGreenFoodiefy))

            Text("Diseña tu alimentación y alcanza tus metas. Estamos aquí para ayudarte a construir una vida más saludable.")
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

private struct OnboardingImageView: View {
    var body: some View {
        Image(.foodiefyIcon)
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
    }
}

private struct OnboardingButtonView: View {
    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        Button(action: {
            router.navigate(to: .onboardingForm)
        }) {
            Text("Comenzar")
        }
        .buttonStyle(FoodiefyButtonStyle())
        .padding(.horizontal, 40)
    }
}
