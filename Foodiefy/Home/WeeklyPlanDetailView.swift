import SwiftUI

struct MealPlanDetailView: View {
    let mealPlan: MealPlanService.MealPlanResponse
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Detalles del Plan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)

                Text(mealPlan.mealPlan)
                    .padding()
            }
        }
        .navigationTitle("Plan Alimenticio")
        .navigationBarTitleDisplayMode(.inline)
    }
}
