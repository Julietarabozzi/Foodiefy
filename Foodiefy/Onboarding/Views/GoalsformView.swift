import SwiftUI

struct GoalsFormView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    @State private var selectedGoal: String = ""

    var body: some View {
        ZStack {

            VStack(spacing: 20) {
                Spacer()

                GoalsHeaderView()
                
                Spacer()
                
                GoalsSelectionView(selectedGoal: $selectedGoal)

                Spacer()

                GoalsNextButtonView(viewModel: viewModel, selectedGoal: selectedGoal)
                    .environmentObject(router)

                Spacer()
            }
        }
        .modifier(NavigationBackModifier(color: Color(.darkViolet)))
        .navigationBarBackButtonHidden(true)
    }
}

private struct GoalsHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("¿Cuál es tu objetivo?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(.darkGreenFoodiefy))
        }
    }
}

private struct GoalsSelectionView: View {
    @Binding var selectedGoal: String

    var body: some View {
        VStack(spacing: 15) {
            GoalOptionButton(label: "Ganar peso", isSelected: selectedGoal == "Ganar peso") {
                selectedGoal = "Ganar peso"
            }
            GoalOptionButton(label: "Perder peso", isSelected: selectedGoal == "Perder peso") {
                selectedGoal = "Perder peso"
            }
            GoalOptionButton(label: "Mantener peso", isSelected: selectedGoal == "Mantener peso") {
                selectedGoal = "Mantener peso"
            }
        }
        .padding(.horizontal, 40)
    }
}

private struct GoalsNextButtonView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    var selectedGoal: String

    var body: some View {
        Button(action: {
            viewModel.goals = selectedGoal
            router.navigate(to: .dietaryPreferences)
        }) {
            Text("Siguiente")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(FoodiefyButtonStyle())
        .padding(.horizontal, 40)
        .disabled(selectedGoal.isEmpty)
        .opacity(selectedGoal.isEmpty ? 0.5 : 1)
    }
}

private struct GoalOptionButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.headline)
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
            }
            .padding()
            .background(isSelected ? Color(.darkViolet) : Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}
