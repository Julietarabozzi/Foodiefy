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
                    Text("Creado el \(formatDate(createdAt))")
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
        return icons[Int(plan.id.hashValue) % icons.count]
    }
    
    func getColorForPlan(_ plan: MealPlanService.MealPlanResponse) -> Color {
        let colors: [Color] = [.green, .blue, .orange, .red, .purple, .pink, .yellow]
        return colors[Int(plan.id.hashValue) % colors.count]
    }
    
    func formatDate(_ dateString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            return outputFormatter.string(from: date)
        }
        return "Fecha desconocida"
    }
}
