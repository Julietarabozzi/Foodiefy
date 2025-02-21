import SwiftUI

struct LoadingView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @Binding var navigateToHome: Bool

    var body: some View {
        VStack(spacing: 30) {
            Spacer()

            Image(systemName: "hourglass")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)

            Text("Estamos preparando tu plan alimenticio...")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)

            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear {
            if !viewModel.mealPlan.isEmpty {
                navigateToHome = true
                
            }
        }
    }
}
