import Foundation
import SwiftUI

struct ActivityLevelView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel // ViewModel compartido
    @State private var selectedActivityLevel: String = ""
    @EnvironmentObject var router: AppRouter // Agregamos el router

    let activityLevels = ["Principiante", "Intermedio", "Avanzado"]

    var body: some View {
        ZStack {
            Color("greyBackground").edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()

                Text("¿Cuál es tu nivel de actividad física?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("darkGreenFoodiefy"))

                Spacer()

                VStack(spacing: 15) {
                    ForEach(activityLevels, id: \ .self) { level in
                        ActivityLevelOptionButton(
                            label: level,
                            isSelected: selectedActivityLevel == level,
                            action: { selectedActivityLevel = level }
                        )
                    }
                }
                .padding(.horizontal, 40)

                Spacer()

                Button(action: {
                    // Guardar el nivel de actividad en el ViewModel
                    viewModel.activityLevel = selectedActivityLevel
                    print("Nivel de actividad física seleccionado: \(viewModel.activityLevel)")
                    router.navigate(to: .summary) // ✅ Navegar a la siguiente vista con el router
                }) {
                    Text("Siguiente")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(FoodiefyButtonStyle())
                .padding(.horizontal, 40)
                .disabled(selectedActivityLevel.isEmpty)

                Spacer()
            }
        }
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
        .navigationBarHidden(true)
    }
}

// Componente reutilizable para las opciones de nivel de actividad física
struct ActivityLevelOptionButton: View {
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

