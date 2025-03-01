import SwiftUI

struct MealPlanCard: View {
    let mealPlan: MealPlanService.MealPlanResponse

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: getIconForPlan(mealPlan))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(getColorForPlan(mealPlan))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Plan Alimenticio")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                if let createdAt = mealPlan.createdAt {
                    let formattedDate = formatDateRange(createdAt)
                    Text("Semana: \(formattedDate)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text("Semana desconocida")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Text("Ver detalles")
                    .font(.footnote)
                    .foregroundColor(Color("darkGreenFoodiefy"))
            }
            Spacer()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5))
    }
    
    func getIconForPlan(_ plan: MealPlanService.MealPlanResponse) -> String {
        let icons = ["fork.knife", "leaf", "flame", "cup.and.saucer", "cart", "sparkles", "heart"]
        let index = abs(plan.id.hashValue) % icons.count
        return icons[index]
    }
    
    func getColorForPlan(_ plan: MealPlanService.MealPlanResponse) -> Color {
        let colors: [Color] = [.green, .blue, .orange, .red, .purple, .pink, .yellow]
        let index = abs(plan.id.hashValue) % colors.count
        return colors[index]
    }
    
    /// 🔹 **Calcula el rango de fechas semanales**
    func formatDateRange(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Soporta milisegundos
        
        if let startDate = formatter.date(from: dateString) {
            let calendar = Calendar.current
            let endDate = calendar.date(byAdding: .day, value: 7, to: startDate) ?? startDate

            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "d/M" // 🔹 Formato "1/3"

            return "\(outputFormatter.string(from: startDate)) al \(outputFormatter.string(from: endDate))"
        } else {
            return "Fecha desconocida"
        }
    }
}
