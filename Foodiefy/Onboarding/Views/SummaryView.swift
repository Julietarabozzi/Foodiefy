import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @State private var navigateToLoading = false
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    Text("Resumen de tus elecciones")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))

                    Spacer()

                    VStack(alignment: .leading, spacing: 15) {
                        SummaryItemView(label: "Nombre", value: viewModel.name)
                        SummaryItemView(label: "Edad", value: viewModel.age)
                        SummaryItemView(label: "Peso (kg)", value: viewModel.weight)
                        SummaryItemView(label: "Altura (cm)", value: viewModel.height)
                        SummaryItemView(label: "Objetivo", value: viewModel.goals)
                        SummaryItemView(label: "Restricciones alimenticias", value: viewModel.dietaryPreferences.joined(separator: ", "))
                        SummaryItemView(label: "Nivel de actividad física", value: viewModel.activityLevel)
                    }
                    .padding(.horizontal, 40)

                    Spacer()

                    Button(action: {
                        viewModel.sendDataToBackend { success in
                            if success {
                                print("✅ Datos enviados al backend.")
                                navigateToLoading = true
                            } else {
                                print("❌ Error al enviar los datos.")
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

                NavigationLink(destination: LoadingView(navigateToHome: $navigateToHome), isActive: $navigateToLoading) { EmptyView() }
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) { EmptyView() }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet")))
            .navigationBarHidden(true)
        }
    }
}

// Componente reutilizable para los ítems del resumen
struct SummaryItemView: View {
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

