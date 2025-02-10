//
//  SummaryView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 21/11/2024.
//

import Foundation
import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel // ViewModel compartido
    @State private var navigateToNextStep = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()

                    Text("Resumen de tus elecciones")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))

                    Spacer()

                    VStack(alignment: .leading, spacing: 15) {
                        SummaryItemView(label: "Nombre", value: viewModel.name)
                        SummaryItemView(label: "Edad", value: viewModel.age)
                        SummaryItemView(label: "Peso (kg)", value: viewModel.weight)
                        SummaryItemView(label: "Altura (cm)", value: viewModel.height)
                        SummaryItemView(label: "Objetivo", value: viewModel.goals)
                        SummaryItemView(label: "Restricciones alimenticias", value: viewModel.dietaryPreferences.joined(separator: ", "))
                        SummaryItemView(label: "Nivel de actividad física", value: viewModel.activityLevel)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()

                    Button(action: {
                        // Enviar datos al backend
                        viewModel.sendDataToBackend { success in
                            if success {
                                print("✅ Datos enviados al backend.")
                                navigateToNextStep = true
                            } else {
                                print("❌ Error al enviar los datos.")
                            }
                        }
                    }) {
                        Text("Confirmar y continuar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }

                NavigationLink(
                    destination: LoadingView(), // Cambia a la vista que sigue después del resumen
                    isActive: $navigateToNextStep
                ) {
                    EmptyView()
                }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet")))
            .navigationBarHidden(true)
        }
    }
}

// Componente reutilizable para los ítems del resumen
struct SummaryItemView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 5)
    }
}

