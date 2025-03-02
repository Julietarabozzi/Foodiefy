import SwiftUI

// 📌 Componente para mostrar secciones en el perfil
struct ProfileCard<Content: View>: View {
    let title: String
    let icon: String
    let content: Content

    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
            }

            content
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

// 📌 Campo de perfil con opción editable
struct ProfileTextField: View {
    let title: String
    @Binding var text: String
    let isEditable: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if isEditable {
                TextField(title, text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            } else {
                Text(text.isEmpty ? "Sin información" : text)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 1)
            }
        }
    }
}

// 📌 Opciones para selección de objetivos (coinciden con el Onboarding)
enum GoalOptions: String, CaseIterable, Identifiable {
    case ganarPeso = "Ganar peso"
    case perderPeso = "Perder peso"
    case mantenerPeso = "Mantener peso"
    
    var id: String { self.rawValue }
}

// 📌 Opciones para selección de restricciones alimenticias (coinciden con el Onboarding)
enum DietaryPreferences: String, CaseIterable, Identifiable {
    case celiaco = "Celíaco"
    case vegetariano = "Vegetariano"
    case vegano = "Vegano"
    case intoleranteLactosa = "Intolerante a la lactosa"
    case noTengo = "No tengo"
    
    var id: String { self.rawValue }
}

// 📌 Opciones para selección del nivel de actividad física (coinciden con el Onboarding)
enum ActivityLevel: String, CaseIterable, Identifiable {
    case principiante = "Principiante"
    case intermedio = "Intermedio"
    case avanzado = "Avanzado"
    
    var id: String { self.rawValue }
}

