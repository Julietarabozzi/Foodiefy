//
//  TabBarView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/11/2024.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        TabView {
            HomeContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ScanView()
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Escaneo")
                }
            
            WeeklyProgressView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Mi progreso")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Mi perfil")
                }
        }
        .accentColor(.purple)
    }
}

// Contenido principal del Home
struct HomeContentView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground")
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    VStack(spacing: 5) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)

                        Text("Hola, \(viewModel.name)!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)

                        Text("Aquí está tu plan alimenticio")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 40)

                    if viewModel.mealPlan.isEmpty {
                        Text("No hay plan generado todavía.")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 15) {
                                Text(viewModel.mealPlan)
                                    .font(.body)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    Spacer()
                }
            }
        }
    }
}
