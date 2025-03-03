import SwiftUI

struct ActivityLevelView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    @State private var selectedActivityLevel: String = ""

    let activityLevels = ["Principiante", "Intermedio", "Avanzado"]

    var body: some View {
        ZStack {

            VStack(spacing: 20) {
                Spacer()

                ActivityHeaderView()
                
                Spacer()

                ActivitySelectionView(activityLevels: activityLevels, selectedActivityLevel: $selectedActivityLevel)

                Spacer()

                ActivityNextButtonView(viewModel: viewModel, selectedActivityLevel: selectedActivityLevel)

                Spacer()
            }
        }
        .modifier(NavigationBackModifier(color: Color(.darkViolet)))
        .navigationBarBackButtonHidden(true)
    }
}

private struct ActivityHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("¿Cuál es tu nivel de actividad física?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(.darkGreenFoodiefy))
        }
    }
}

private struct ActivitySelectionView: View {
    let activityLevels: [String]
    @Binding var selectedActivityLevel: String

    var body: some View {
        VStack(spacing: 15) {
            ForEach(activityLevels, id: \.self) { level in
                ActivityLevelOptionButton(
                    label: level,
                    isSelected: selectedActivityLevel == level,
                    action: { selectedActivityLevel = level }
                )
            }
        }
        .padding(.horizontal, 40)
    }
}

private struct ActivityNextButtonView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    var selectedActivityLevel: String

    var body: some View {
        Button(action: {
            viewModel.activityLevel = selectedActivityLevel
            router.navigate(to: .summary)
        }) {
            Text("Siguiente")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(FoodiefyButtonStyle())
        .padding(.horizontal, 40)
        .disabled(selectedActivityLevel.isEmpty)
        .opacity(selectedActivityLevel.isEmpty ? 0.5 : 1)
    }
}

private struct ActivityLevelOptionButton: View {
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
