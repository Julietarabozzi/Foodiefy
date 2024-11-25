//
//  ScanView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/11/2024.
//

import Foundation
import SwiftUI

struct ScanView: View {
    var body: some View {
        ZStack {
            // Fondo
            Color("greyBackground")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Spacer()

                // Ícono de la foto
                Image(systemName: "camera.viewfinder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)
                
                // Texto para indicar acción
                Text("Presiona para escanear")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                // Botón para escanear
                Button(action: {
                    print("Escanear iniciado")
                    // Aquí puedes agregar la lógica del escaneo
                }) {
                    Text("Escanear")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(Color("darkGreenFoodiefy"))
                        .cornerRadius(100)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                        .padding(.horizontal, 40)
                }
                
                Spacer()
            }
        }
        .navigationTitle("Escaneo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
