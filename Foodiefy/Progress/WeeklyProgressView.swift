import SwiftUI

struct WeeklyProgressView: View {
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        VStack {
            Text("Seguimiento del Plan")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            if progressViewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                ForEach(0..<7, id: \.self) { index in
                    HStack {
                        Text("Día \(index + 1)")
                            .font(.headline)
                            .frame(width: 80, alignment: .leading)

                        Spacer()

                        Button(action: {
                            guard let userId = sessionManager.userId else { return }
                            let newValue = !progressViewModel.weeklyProgress[index]
                            progressViewModel.weeklyProgress[index] = newValue
                            progressViewModel.updateProgress(day: index + 1, completed: newValue, token: sessionManager.token ?? "", userId: userId)
                        }) {
                            Text(progressViewModel.weeklyProgress[safe: index] ?? false ? "✅ Cumplido" : "❌ No cumplido")
                                .font(.subheadline)
                                .padding(10)
                                .background(progressViewModel.weeklyProgress[safe: index] ?? false ? Color.green.opacity(0.7) : Color.red.opacity(0.7))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .shadow(radius: 2))
                    .padding(.horizontal)
                }
            }
            Spacer()
        }
    }
}

// 🔹 Extensión para evitar Index out of range
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
