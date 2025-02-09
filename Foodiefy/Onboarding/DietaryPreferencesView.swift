import SwiftUI

struct DietaryPreferencesView: View {
    @State private var selectedPreferences: [String] = []
    @State private var navigateToNextView = false

    let preferences = [
        "Celíaco",
        "Vegetariano",
        "Vegano",
        "Intolerante a la lactosa",
        "No tengo"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // Título de la pantalla
                    Text("¿Tienes alguna preferencia o restricción alimenticia?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))

                    Spacer()

                    // Opciones del formulario
                    VStack(spacing: 15) {
                        ForEach(preferences, id: \.self) { preference in
                            DietaryOptionButton(
                                label: preference,
                                isSelected: selectedPreferences.contains(preference),
                                action: {
                                    if preference == "No tengo" {
                                        // Si selecciona "No tengo", deselecciona todas las demás
                                        selectedPreferences = ["No tengo"]
                                    } else {
                                        // Desmarcar "No tengo" si selecciona otra
                                        selectedPreferences.removeAll { $0 == "No tengo" }
                                        // Alternar selección
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

                    // Botón para continuar
                    Button(action: {
                        // Acción para continuar
                        print("Preferencias seleccionadas: \(selectedPreferences)")
                        navigateToNextView = true
                    }) {
                        Text("Siguiente")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)
                    .disabled(selectedPreferences.isEmpty) // Deshabilitar si no selecciona nada
                    
                    Spacer()
                }

                // NavigationLink oculto para la navegación programática
                NavigationLink(
                    destination: ActivityLevelView(), // Reemplaza con la próxima vista
                    isActive: $navigateToNextView
                ) {
                    EmptyView()
                }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet"))) // Aquí aplicamos el modificador
            .navigationBarHidden(true)
        }
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

