//
//  WeeklyProgressView\.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 14/11/2024.
//

import Foundation
import SwiftUI
import Charts

struct WeeklyProgressView: View {
    // Datos de ejemplo para el progreso semanal
    let progressData = [
        ("Lunes", 80),  // 80% completado
        ("Martes", 50),
        ("Miércoles", 100),
        ("Jueves", 60),
        ("Viernes", 90),
        ("Sábado", 70),
        ("Domingo", 40)
    ]

    var body: some View {
        VStack {
            Text("Progreso Semanal")
                .font(.title)
                .padding(.bottom, 20)
            
            Chart {
                ForEach(progressData, id: \.0) { day, value in
                    BarMark(
                        x: .value("Día", day),
                        y: .value("Progreso", value)
                    )
                    .foregroundStyle(value >= 70 ? Color.green : Color.orange) // Verde si supera el 70%
                }
            }
            .frame(height: 300) // Altura del gráfico
            .padding()
        }
        .padding()
    }
}
