//
//  File.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 21/11/2024.
//

import Foundation
import SwiftUI

struct ActivityLevelView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel // ViewModel compartido
    @State private var selectedActivityLevel: String = ""
    @State private var navigateToNextView = false

    let activityLevels = ["Principiante", "Intermedio", "Avanzado"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    Text("¿Cuál es tu nivel de actividad física?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))

                    Spacer()

                    VStack(spacing: 15) {
                        ForEach(activityLevels, id: \.self) { level in
                            ActivityLevelOptionButton(
                                label: level,
                                isSelected: selectedActivityLevel == level,
                                action: { selectedActivityLevel = level }
                            )
                        }
                    }
                    .padding(.horizontal, 40)

                    Spacer()

                    Button(action: {
                        // Guardar el nivel de actividad en el ViewModel
                        viewModel.activityLevel = selectedActivityLevel
                        print("Nivel de actividad física seleccionado: \(viewModel.activityLevel)")
                        navigateToNextView = true
                    }) {
                        Text("Siguiente")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)
                    .disabled(selectedActivityLevel.isEmpty)

                    Spacer()
                }

                NavigationLink(
                    destination: SummaryView().environmentObject(viewModel), // Pasar el ViewModel a la próxima vista
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

// Componente reutilizable para las opciones de nivel de actividad física
struct ActivityLevelOptionButton: View {
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

