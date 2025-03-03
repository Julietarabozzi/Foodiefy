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
    @StateObject private var foodScannerViewModel = FoodScannerViewModel()

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            ScanView(viewModel: foodScannerViewModel)
                .tabItem {
                    Image(systemName: "camera.fill")
                    Text("Escaneo")
                }
            
            ProgressTabView() 
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
