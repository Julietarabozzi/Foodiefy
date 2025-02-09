import SwiftUI

struct FoodiefyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(Color.darkGreenFoodiefy)
            .cornerRadius(16) // Cambié de 100 a 16 para que se vea más moderno
            .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0) // Efecto de escala más sutil
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
            .padding(.horizontal, 30)
    }
}
