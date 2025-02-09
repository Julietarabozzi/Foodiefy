//
//  File.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 21/11/2024.
//

import Foundation
import SwiftUI

struct ActivityLevelView: View {
    @State private var selectedActivityLevel: String = ""
    @State private var navigateToNextView = false

    let activityLevels = [
        "Principiante",
        "Intermedio",
        "Avanzado"
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Spacer()

                    // Título de la pantalla
                    Text("¿Cuál es tu nivel de actividad física?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))
                    Spacer()

                    // Opciones del formulario
                    VStack(spacing: 15) {
                        ForEach(activityLevels, id: \.self) { level in
                            ActivityLevelOptionButton(
                                label: level,
                                isSelected: selectedActivityLevel == level,
                                action: {
                                    selectedActivityLevel = level
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 40)

                    Spacer()

                    // Botón para continuar
                    Button(action: {
                        // Acción para continuar
                        print("Nivel de actividad física seleccionado: \(selectedActivityLevel)")
                        navigateToNextView = true
                    }) {
                        Text("Siguiente")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)
                    .disabled(selectedActivityLevel.isEmpty) // Deshabilitar si no se selecciona nada
                    
                    Spacer()
                }

                // NavigationLink oculto para la navegación programática
                NavigationLink(
                    destination: SummaryView(), // Reemplaza con la próxima vista
                    isActive: $navigateToNextView
                ) {
                    EmptyView()
                }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet"))) // Aquí aplicamos el modificador
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

