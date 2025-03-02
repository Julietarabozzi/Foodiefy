import SwiftUI

// 📌 Componente para mostrar secciones en el perfil
import SwiftUI

// 📌 Componente para mostrar secciones en el perfil con icono y botón de edición
struct ProfileCard<Content: View>: View {
    let title: String
    let icon: String
    let isEditable: Bool
    let onEdit: (() -> Void)?
    let content: Content

    init(title: String, icon: String, isEditable: Bool = false, onEdit: (() -> Void)? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.isEditable = isEditable
        self.onEdit = onEdit
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Label(title, systemImage: icon)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Spacer()
                
                if isEditable, let onEdit = onEdit {
                    Button(action: onEdit) {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.blue)
                    }
                }
            }

            content
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}
// 📌 Campo de perfil con opción editable
import SwiftUI

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

// 📌 Opciones para selección de objetivos
enum GoalOptions: String, CaseIterable {
    case perderPeso = "Perder peso"
    case mantenerPeso = "Mantenerme"
    case ganarMasa = "Ganar masa muscular"
}

// 📌 Opciones para selección de restricciones alimenticias
enum DietaryPreferencesOptions: String, CaseIterable {
    case vegano = "Vegano"
    case vegetariano = "Vegetariano"
    case sinGluten = "Sin gluten"
    case sinLactosa = "Sin lactosa"
    case omnivoro = "Omnívoro"
}

// 📌 Opciones para selección del nivel de actividad física
enum ActivityLevelOptions: String, CaseIterable {
    case sedentario = "Sedentario"
    case ligero = "Ligero"
    case moderado = "Moderado"
    case activo = "Activo"
    case muyActivo = "Muy activo"
}
