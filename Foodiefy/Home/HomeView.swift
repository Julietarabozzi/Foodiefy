import SwiftUI

struct HomeView: View {
    @EnvironmentObject var mealPlanViewModel: MealPlanViewModel
    @EnvironmentObject var sessionManager: UserSessionManager

    var body: some View {
        NavigationView {
            ZStack {
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Header con icono y saludo
                    VStack(spacing: 5) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color("darkGreenFoodiefy"))

                        Text("Hola, \(sessionManager.name ?? "usuario")!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        Text("Aquí están tus planes alimenticios")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    if mealPlanViewModel.mealPlans.isEmpty {
                        Text("No hay planes generados todavía.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(mealPlanViewModel.mealPlans, id: \.id) { plan in
                                    NavigationLink(destination: MealPlanDetailView(mealPlan: plan)) {
                                        MealPlanCard(mealPlan: plan)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    Spacer()
                }
            }
            .navigationTitle("Tus Planes")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                mealPlanViewModel.fetchMealPlans(sessionManager: sessionManager)
            }
        }
    }
}
