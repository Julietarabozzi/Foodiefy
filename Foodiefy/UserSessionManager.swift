//
//  UserSessionManager.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 23/02/2025.
//

import Foundation
import SwiftUI

class UserSessionManager: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }

    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    func login() {
        DispatchQueue.main.async {
            self.isLoggedIn = true
        }
    }

    func logout() {
        DispatchQueue.main.async {
            self.isLoggedIn = false
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
        }
    }
}
