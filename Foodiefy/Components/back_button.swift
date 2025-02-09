import SwiftUI

struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode // Navegación atrás automática

    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss() // Navega hacia atrás
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color("darkViolet")) // Cambia el color del ícono
                .font(.system(size: 20, weight: .bold)) // Tamaño y grosor del ícono
                .overlay(
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color("darkViolet").opacity(0.2)) // Contorno más claro
                        .font(.system(size: 25, weight: .bold))
                )
        }
    }
}
