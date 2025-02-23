//
//  WeeklyPlanCard.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/02/2025.
//

// 🔹 Tarjeta de resumen del plan semanal
import SwiftUI

struct WeeklyPlanCard: View {
    let week: WeeklyMealPlan
    let index: Int
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: getIconForIndex(index))
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(getColorForIndex(index))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Plan semanal")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text("\(week.startDate) - \(week.endDate)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Ver detalle")
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
    
    func getIconForIndex(_ index: Int) -> String {
        let icons = ["fork.knife", "leaf", "flame", "cup.and.saucer", "cart", "sparkles", "heart"]
        return icons[index % icons.count]
    }
    
    func getColorForIndex(_ index: Int) -> Color {
        let colors: [Color] = [.green, .blue, .orange, .red, .purple, .pink, .yellow]
        return colors[index % colors.count]
    }
}
