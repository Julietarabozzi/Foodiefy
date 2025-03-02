import SwiftUI

struct WeeklyProgressChartView: View {
    @EnvironmentObject var progressViewModel: ProgressViewModel

    var progressPercentage: Double {
        let completedDays = progressViewModel.weeklyProgress.filter { $0 }.count
        return (Double(completedDays) / 7.0) * 100
    }

    var body: some View {
        VStack {
            Text("Cumplimiento semanal")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            // 🔹 Barra de progreso
            ProgressView(value: progressPercentage, total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: progressColor()))
                .frame(height: 20)
                .padding(.horizontal, 30)
                .overlay(
                    Text("\(Int(progressPercentage))%")
                        .font(.headline)
                        .foregroundColor(.white)
                        .bold()
                        .offset(y: -25) // Ajusta la posición del porcentaje
                )

            Text(motivationalMessage())
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top, 5)
        }
        .padding()
    }

    // 🔹 Cambia el color según el progreso
    private func progressColor() -> Color {
        switch progressPercentage {
        case 0..<30: return .red
        case 30..<70: return .orange
        default: return .green
        }
    }

    // 🔹 Mensajes motivacionales según el progreso
    private func motivationalMessage() -> String {
        switch progressPercentage {
        case 0..<30: return "¡Ánimo! Aún puedes mejorar esta semana. 💪"
        case 30..<70: return "Vas por buen camino, sigue así. 🚀"
        default: return "¡Increíble! Mantén este ritmo. 🎉"
        }
    }
}
