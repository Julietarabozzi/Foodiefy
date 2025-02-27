import Foundation
import SwiftUI

class UserSessionManager: ObservableObject {
    @Published var isLoggedIn: Bool {
        didSet {
            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
        }
    }

    @Published var token: String? {
        didSet {
            UserDefaults.standard.set(token, forKey: "token")
        }
    }

    @Published var userId: String? {
        didSet {
            UserDefaults.standard.set(userId, forKey: "userId")
        }
    }

    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.token = UserDefaults.standard.string(forKey: "token")
        self.userId = UserDefaults.standard.string(forKey: "userId")
    }

    func login() {
        DispatchQueue.main.async {
            self.isLoggedIn = true
        }
    }

    func logout() {
        DispatchQueue.main.async {
            self.isLoggedIn = false
            self.token = nil
            self.userId = nil
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "userId")
        }
    }
}
