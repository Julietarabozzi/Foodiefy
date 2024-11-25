import SwiftUI

struct OnboardingFormView: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var navigateToNextView = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // Título de la pantalla
                    Text("Cuéntanos sobre ti")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    Spacer()

                    // Campos del formulario
                    Group {
                        TextField("Nombre", text: $name)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 40)

                        TextField("Edad", text: $age)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.numberPad)
                            .padding(.horizontal, 40)

                        TextField("Peso (kg)", text: $weight)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal, 40)

                        TextField("Altura (cm)", text: $height)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .keyboardType(.decimalPad)
                            .padding(.horizontal, 40)
                    }

                    Spacer()

                    // Botón para finalizar el onboarding
                    Button(action: {
                        // Acción para finalizar el onboarding
                        print("Información del usuario:")
                        print("Nombre: \(name)")
                        print("Edad: \(age)")
                        print("Peso: \(weight)")
                        print("Altura: \(height)")
                        navigateToNextView = true
                    }) {
                        Text("Siguiente")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)

                    Spacer()
                }

                // NavigationLink oculto para la navegación programática
                NavigationLink(
                    destination: GoalsformView(), // Reemplaza con la vista de destino
                    isActive: $navigateToNextView
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

