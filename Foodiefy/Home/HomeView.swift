import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
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

                        Text("Hola, \(viewModel.name)!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        Text("Aquí están tus planes alimenticios")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    if viewModel.weeklyPlans.isEmpty {
                        Text("No hay planes generados todavía.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(Array(viewModel.weeklyPlans.enumerated()), id: \ .element.id) { index, week in
                                    NavigationLink(destination: WeeklyPlanDetailView(week: week)) {
                                        WeeklyPlanCard(week: week, index: index)
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
        }
    }
