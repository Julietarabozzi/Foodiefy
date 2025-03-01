//
//  FoodiefyApp.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 14/11/2024.
//

import SwiftUI

@main
struct FoodiefyApp: App {
    @StateObject private var sessionManager = UserSessionManager()
    @StateObject private var router = AppRouter()
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    @StateObject private var mealPlanViewModel = MealPlanViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(sessionManager)
                .environmentObject(router)
                .environmentObject(onboardingViewModel)
                .environmentObject(mealPlanViewModel)
        }
    }
}
