//
//  NextOnboardingView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 19/11/2024.
//

import SwiftUI

import SwiftUI

struct GoalsformView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel // ViewModel compartido
    @State private var selectedGoal: String = ""
    @State private var navigateToNextView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    Text("¿Cuál es tu objetivo?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))
                    
                    Spacer()

                    VStack(spacing: 15) {
                        GoalOptionButton(label: "Ganar peso", isSelected: selectedGoal == "Ganar peso") {
                            selectedGoal = "Ganar peso"
                        }
                        GoalOptionButton(label: "Perder peso", isSelected: selectedGoal == "Perder peso") {
                            selectedGoal = "Perder peso"
                        }
                        GoalOptionButton(label: "Mantener peso", isSelected: selectedGoal == "Mantener peso") {
                            selectedGoal = "Mantener peso"
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()

                    Button(action: {
                        // Guardar el objetivo seleccionado en el ViewModel
                        viewModel.goals = selectedGoal
                        print("Objetivo seleccionado: \(viewModel.goals)")
                        navigateToNextView = true
                    }) {
                        Text("Siguiente")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)
                    .disabled(selectedGoal.isEmpty)
                    
                    Spacer()
                }
                
                NavigationLink(
                    destination: DietaryPreferencesView().environmentObject(viewModel), // Pasar el ViewModel a la próxima vista
                    isActive: $navigateToNextView
                ) {
                    EmptyView()
                }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet")))
            .navigationBarHidden(true)
        }
    }
}

// Componente reutilizable para las opciones del objetivo
struct GoalOptionButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.headline)
                    .foregroundColor(isSelected ? .white : .primary)
                Spacer()
            }
            .padding()
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .cornerRadius(8)
        }
    }
}

// Vista para las restricciones alimenticias
