//
//  TabBarView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/11/2024.
//

import Foundation
import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            // Pantalla principal con la lista de planes
            HomeContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            // Pantalla de escaneo
            ScanView()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Escaneo")
                }
            
            // Pantalla de progreso
            WeeklyProgressView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Mi progreso")
                }
            
            // Pantalla de perfil
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Mi perfil")
                }
        }
        .accentColor(.purple) // Color del Tab Bar
    }
}

// Contenido principal del Home
struct HomeContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Fondo
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Encabezado
                    VStack(spacing: 5) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                        
                        Text("Hola, usuario!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("Aquí podrás ver tus planes")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)

                    // Lista de planes
                    ScrollView {
                        VStack(spacing: 15) {
                            PlanCardView(planTitle: "Plan semanal", dateRange: "13 - 19 de noviembre")
                            PlanCardView(planTitle: "Plan semanal", dateRange: "6 - 13 de noviembre")
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

// Componente para cada tarjeta de plan
struct PlanCardView: View {
    let planTitle: String
    let dateRange: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "photo") // Reemplaza con una imagen personalizada
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(8)
                
                VStack(alignment: .leading) {
                    Text(planTitle)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(dateRange)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}
