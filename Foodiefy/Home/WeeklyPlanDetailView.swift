//
//  WeeklyPlanDetailView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/02/2025.
//

import SwiftUI

// 🔹 Pantalla de detalle del plan semanal
struct WeeklyPlanDetailView: View {
    let week: WeeklyMealPlan
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Plan de comidas de la semana")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Text(week.meals)
                    .padding()
            }
        }
        .navigationTitle("Detalles del Plan")
        .navigationBarTitleDisplayMode(.inline)
    }
}

