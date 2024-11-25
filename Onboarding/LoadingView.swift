//
//  LoadingView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 21/11/2024.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    @State private var isLoading = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    // Ilustración
                    Image(systemName: "hourglass") // Cambia a tu ilustración personalizada
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                    
                    // Texto de "procesando"
                    Text("Estamos preparando todo para ti...")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    // Indicador de carga
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                        .scaleEffect(2) // Escalar para que sea más grande
                    
                    Spacer()
                }
                .navigationBarTitle("", displayMode: .inline)
            }
            .onAppear {
                // Simula el tiempo de carga y navega automáticamente después de 5 segundos
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    isLoading = false
                }
            }
            .background(
                NavigationLink(
                    destination: HomeView(), // Cambia a la vista final o siguiente
                    isActive: .constant(!isLoading)
                ) {
                    EmptyView()
                }
            )
        }
    }
}
