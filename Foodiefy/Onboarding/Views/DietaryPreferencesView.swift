import SwiftUI

struct DietaryPreferencesView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    @State private var selectedPreferences: [String] = []

    let preferences = [
        "Celíaco",
        "Vegetariano",
        "Vegano",
        "Intolerante a la lactosa",
        "No tengo"
    ]
    
    var body: some View {
        ZStack {

            VStack(spacing: 20) {
                Spacer()

                DietaryHeaderView()
                Spacer()
                
                DietaryOptionsView(preferences: preferences, selectedPreferences: $selectedPreferences)

                Spacer()

                DietaryNextButtonView(viewModel: viewModel, selectedPreferences: selectedPreferences)

                Spacer()
            }
        }
        .modifier(NavigationBackModifier(color: Color(.darkViolet)))
        .navigationBarBackButtonHidden(true)
    }
}

private struct DietaryHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("¿Tienes alguna preferencia o restricción alimenticia?")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(.darkGreenFoodiefy))
        }
        .padding()
    }
}

private struct DietaryOptionsView: View {
    let preferences: [String]
    @Binding var selectedPreferences: [String]

    var body: some View {
        VStack(spacing: 15) {
            ForEach(preferences, id: \.self) { preference in
                DietaryOptionButton(
                    label: preference,
                    isSelected: selectedPreferences.contains(preference),
                    action: {
                        if preference == "No tengo" {
                            selectedPreferences = ["No tengo"]
                        } else {
                            selectedPreferences.removeAll { $0 == "No tengo" }
                            if selectedPreferences.contains(preference) {
                                selectedPreferences.removeAll { $0 == preference }
                            } else {
                                selectedPreferences.append(preference)
                            }
                        }
                    }
                )
            }
        }
        .padding(.horizontal, 40)
    }
}

private struct DietaryNextButtonView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    var selectedPreferences: [String]

    var body: some View {
        Button(action: {
            viewModel.dietaryPreferences = selectedPreferences
            router.navigate(to: .activityLevel)
        }) {
            Text("Siguiente")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(FoodiefyButtonStyle())
        .padding(.horizontal, 40)
        .disabled(selectedPreferences.isEmpty)
        .opacity(selectedPreferences.isEmpty ? 0.5 : 1)
    }
}

private struct DietaryOptionButton: View {
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

#Preview {
    DietaryPreferencesView()
        .environmentObject(OnboardingViewModel())
        .environmentObject(AppRouter())
}
