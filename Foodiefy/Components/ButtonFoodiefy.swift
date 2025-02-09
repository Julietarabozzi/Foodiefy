import SwiftUI

struct FoodiefyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(Color("darkGreenFoodiefy"))
            .cornerRadius(100)
            .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
            .opacity(configuration.isPressed ? 0.8 : 1.0) // Efecto visual al presionar
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0) // Efecto de escala al presionar
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .padding(.horizontal, 40)
    }
}
