import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        ZStack {

            VStack(spacing: 20) {
                Spacer()

                SummaryHeaderView()
                Spacer()
                SummaryDetailsView(viewModel: viewModel)

                Spacer()

                SummaryConfirmButton()

                Spacer()
            }
        }
        .modifier(NavigationBackModifier(color: Color(.darkViolet)))
        .navigationBarBackButtonHidden(true)
    }
}

private struct SummaryHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Resumen de tus elecciones")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(.darkGreenFoodiefy))
        }
    }
}

private struct SummaryDetailsView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            SummaryItemView(label: "Edad", value: viewModel.age)
            SummaryItemView(label: "Peso (kg)", value: viewModel.weight)
            SummaryItemView(label: "Altura (cm)", value: viewModel.height)
            SummaryItemView(label: "Objetivo", value: viewModel.goals)
            SummaryItemView(label: "Restricciones alimenticias", value: viewModel.dietaryPreferences.joined(separator: ", "))
            SummaryItemView(label: "Nivel de actividad física", value: viewModel.activityLevel)
        }
        .padding(.horizontal, 40)
    }
}

private struct SummaryConfirmButton: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        Button(action: {
            viewModel.sendDataToBackend(sessionManager: sessionManager) { success in
                if success {
                    router.navigate(to: .loading)
                } else {
                }
            }
        }) {
            if viewModel.isSubmitting {
                ProgressView()
            } else {
                Text("Confirmar y continuar")
                    .frame(maxWidth: .infinity)
            }
        }
        .buttonStyle(FoodiefyButtonStyle())
        .padding(.horizontal, 40)
    }
}

private struct SummaryItemView: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
    }
}
