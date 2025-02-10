//
//  FoodiefyApp.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 14/11/2024.
//

import SwiftUI

@main
struct FoodiefyApp: App {
    @StateObject private var onboardingViewModel = OnboardingViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(onboardingViewModel)
        }
    }
}
