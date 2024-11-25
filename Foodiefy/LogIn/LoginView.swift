import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var navigateToHome = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()

                    // Encabezado
                    Text("Bienvenido a Foodiefy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Spacer()

                    // Campos de entrada
                    VStack(spacing: 15) {
                        TextField("Correo electrónico", text: $email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 40)
                        
                        SecureField("Contraseña", text: $password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 40)
                    }
                    
                    Spacer()

                    // Botón para iniciar sesión
                    Button(action: {
                        print("Iniciando sesión con: \(email)")
                        navigateToHome = true // Activa la navegación al presionar
                    }) {
                        Text("Iniciar sesión")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, minHeight: 52)
                            .background(Color("darkGreenFoodiefy"))
                            .cornerRadius(100)
                            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                    }
                    .padding(.horizontal, 40)

                    Spacer()
                }

                // Navegación programática al Home
                NavigationLink(
                    destination: HomeView(), // Navega a la vista Home
                    isActive: $navigateToHome
                ) {
                    EmptyView()
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
    }
}

