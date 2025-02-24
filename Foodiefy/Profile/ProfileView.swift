import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var sessionManager: UserSessionManager
    @EnvironmentObject var router: AppRouter
    
    // Datos del perfil
    @State private var name: String = "Julieta Rabozzi"
    @State private var age: String = "25"
    @State private var weight: String = "55"
    @State private var height: String = "165"
    @State private var goal: String = "Mantener peso"
    @State private var dietaryPreferences: [String] = ["Vegetariano", "Intolerante a la lactosa"]
    @State private var activityLevel: String = "Intermedio"

    var body: some View {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(alignment:.leading, spacing: 20) {
                        // Encabezado
                        Text("Mi Perfil")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding()

                        // Visualización de los datos
                        VStack(spacing: 15) {
                            HStack {
                                ProfileItemView(label: "Nombre", value: name)
                                Spacer()
                            }
                            HStack{
                                ProfileItemView(label: "Edad", value: age)
                                Spacer()
                            }
                            HStack {
                                ProfileItemView(label: "Peso (kg)", value: weight)
                                Spacer()
                            }
                            
                            HStack{
                                ProfileItemView(label: "Altura (cm)", value: height)
                                Spacer()
                            }

                            HStack {
                                ProfileItemView(label: "Objetivo", value: goal)
                                Spacer()
                            }
                            HStack{
                                ProfileItemView(label: "Restricciones alimenticias", value: dietaryPreferences.joined(separator: ", "))
                                Spacer()
                            }
                            HStack{
                                ProfileItemView(label: "Nivel de actividad física", value: activityLevel)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 40)
                        
                        // Botón de Logout
                        Button(action: {
                            sessionManager.logout()
                        }) {
                            Text("Cerrar sesión")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal, 40)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
        }
}

// Componente reutilizable para los ítems del perfil
struct ProfileItemView: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
    }
}
#Preview{
    ProfileView()
}
