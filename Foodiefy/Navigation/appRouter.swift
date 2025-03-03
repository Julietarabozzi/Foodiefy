//
//  appRouter.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/02/2025.
//

import Foundation
import SwiftUI

class AppRouter: ObservableObject {
    @Published var path = NavigationPath()

    func navigate(to destination: Route) {
        DispatchQueue.main.async {
            self.path.append(destination) // ✅ Aseguramos actualización en la UI
        }
    }

    func goBack() {
        if !path.isEmpty {
            DispatchQueue.main.async {
                self.path.removeLast()
            }
        }
    }

    func reset() {
        DispatchQueue.main.async {
            self.path = NavigationPath()
        }
    }
}

enum Route: Hashable {
    case login
    case register
    case home
    case onboarding
    case onboardingForm
    case goalsForm
    case dietaryPreferences
    case activityLevel
    case summary
    case loading
    case verification
}
