import SwiftUI

struct OnboardingFormView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel // ViewModel compartido
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @EnvironmentObject var router: AppRouter // Agregamos el router

    var body: some View {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    Text("Cuéntanos sobre ti")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))
                    
                    Spacer()

                    Group {
                        FoodiefyTextField(placeholder: "Nombre", text: $name)
                        FoodiefyTextField(placeholder: "Edad", text: $age)
                            .keyboardType(.numberPad)
                        FoodiefyTextField(placeholder: "Peso (kg)", text: $weight)
                            .keyboardType(.decimalPad)
                        FoodiefyTextField(placeholder: "Altura (cm)", text: $height)
                            .keyboardType(.decimalPad)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()

                    Button(action: {
                        // Guardar la información del usuario en el ViewModel
                        viewModel.name = name
                        viewModel.age = age
                        viewModel.weight = weight
                        viewModel.height = height
                        
                        print("Información del usuario guardada en el ViewModel:")
                        print("Nombre: \(viewModel.name), Edad: \(viewModel.age), Peso: \(viewModel.weight), Altura: \(viewModel.height)")

                        router.navigate(to: .goalsForm) // ✅ Navegar a la siguiente vista con el router
                    }) {
                        Text("Siguiente")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)

                    Spacer()
                }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet")))
            .navigationBarHidden(true)
        }
}

