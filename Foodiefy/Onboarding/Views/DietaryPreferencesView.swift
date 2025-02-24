import SwiftUI

struct DietaryPreferencesView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel // ViewModel compartido
    @State private var selectedPreferences: [String] = []
    @EnvironmentObject var router: AppRouter // Agregamos el router

    let preferences = [
        "Celíaco",
        "Vegetariano",
        "Vegano",
        "Intolerante a la lactosa",
        "No tengo"
    ]
    
    var body: some View {
        ZStack {
            Color("greyBackground").edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Text("¿Tienes alguna preferencia o restricción alimenticia?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkGreenFoodiefy"))

                Spacer()

                VStack(spacing: 15) {
                    ForEach(preferences, id: \ .self) { preference in
                        DietaryOptionButton(
                            label: preference,
                            isSelected: selectedPreferences.contains(preference),
                            action: {
                                if preference == "No tengo" {
                                    selectedPreferences = ["No tengo"] // Si selecciona "No tengo", deselecciona todas las demás
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

                Spacer()

                Button(action: {
                    // Guardar las preferencias seleccionadas en el ViewModel
                    viewModel.dietaryPreferences = selectedPreferences
                    print("Preferencias seleccionadas: \(viewModel.dietaryPreferences)")
                    router.navigate(to: .activityLevel) // ✅ Navegar a la siguiente vista con el router
                }) {
                    Text("Siguiente")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(FoodiefyButtonStyle())
                .padding(.horizontal, 40)
                .disabled(selectedPreferences.isEmpty)
                
                Spacer()
            }
        }
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
        .navigationBarHidden(true)
    }
}

// Componente reutilizable para las opciones de preferencias alimenticias
struct DietaryOptionButton: View {
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
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}
