//
//  TabBarView.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/11/2024.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel

    var body: some View {
        TabView {
            HomeView()
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
        .navigationBarBackButtonHidden(true)
    }
}
