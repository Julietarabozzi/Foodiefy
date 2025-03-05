import SwiftUI

struct WeeklyProgressChartView: View {
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @State private var showCompletionAlert = false

    var progressPercentage: Double {
        let completedDays = progressViewModel.weeklyProgress.filter { $0 }.count
        return (Double(completedDays) / 7.0) * 100
    }

    var body: some View {
        VStack {
            if progressPercentage >= 100 {
                // ✅ Mensaje motivacional cuando se completa la semana
                VStack(spacing: 10) {
                    Text("🎉 ¡Felicidades! 🎉")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.green)

                    Text("Has completado toda la semana con éxito. ¡Sigue así!")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)

                    Button(action: {
                        progressViewModel.resetProgress()
                    }) {
                        Text("Aceptar")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 40)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 5))
                .padding(.horizontal, 20)
            } else {
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
            
            Image(.foodiefyIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .rotationEffect(.degrees(-15))
                .offset(y: 50)
                .padding(.bottom, 32)}
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
