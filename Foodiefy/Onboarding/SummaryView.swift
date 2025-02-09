//
//  SummaryView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 21/11/2024.
//

import Foundation
import SwiftUI

struct SummaryView: View {
    // Simulamos los datos elegidos para la demo
    @State private var name: String = "Julieta Rabozzi"
    @State private var age: String = "25"
    @State private var weight: String = "55"
    @State private var height: String = "165"
    @State private var goal: String = "Mantener peso"
    @State private var dietaryPreferences: [String] = ["Vegetariano", "Intolerante a la lactosa"]
    @State private var activityLevel: String = "Intermedio"
    
    @State private var navigateToNextStep = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Spacer()

                    // Título de la pantalla
                    Text("Resumen de tus elecciones")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))

                    Spacer()

                    // Mostrar los datos
                    VStack(alignment: .leading, spacing: 15) {
                        SummaryItemView(label: "Nombre", value: name)
                        SummaryItemView(label: "Edad", value: age)
                        SummaryItemView(label: "Peso (kg)", value: weight)
                        SummaryItemView(label: "Altura (cm)", value: height)
                        SummaryItemView(label: "Objetivo", value: goal)
                        SummaryItemView(label: "Restricciones alimenticias", value: dietaryPreferences.joined(separator: ", "))
                        SummaryItemView(label: "Nivel de actividad física", value: activityLevel)
                    }
                    .padding(.horizontal, 40)
                    
                    Spacer()

                    // Botón para confirmar o avanzar
                    Button(action: {
                        // Acción para confirmar o continuar
                        print("Datos confirmados: Nombre: \(name), Edad: \(age), etc.")
                        navigateToNextStep = true
                    }) {
                        Text("Confirmar y continuar")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(FoodiefyButtonStyle())
                    .padding(.horizontal, 40)
                    
                    Spacer()
                }

                // NavigationLink oculto para el siguiente paso
                NavigationLink(
                    destination: LoadingView(), // Cambia a la vista que sigue después del resumen
                    isActive: $navigateToNextStep
                ) {
                    EmptyView()
                }
            }
            .modifier(NavigationBackModifier(color: Color("darkViolet"))) // Aquí aplicamos el modificador
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
