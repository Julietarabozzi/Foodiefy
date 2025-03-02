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

    @Published var name: String? {  // ✅ Nuevo campo para almacenar el nombre del usuario
        didSet {
            UserDefaults.standard.set(name, forKey: "userName")
        }
    }

    init() {
        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        self.token = UserDefaults.standard.string(forKey: "token")
        self.userId = UserDefaults.standard.string(forKey: "userId")
        self.name = UserDefaults.standard.string(forKey: "userName") // ✅ Recuperar el nombre almacenado
    }

    func login(name: String, token: String, userId: String) {
        DispatchQueue.main.async {
            self.isLoggedIn = true
            self.name = name // ✅ Guardamos el nombre en la sesión
            self.token = token
            self.userId = userId
        }
    }

    func logout() {
        DispatchQueue.main.async {
            self.isLoggedIn = false
            self.token = nil
            self.userId = nil
            self.name = nil // ✅ Limpiamos el nombre en el logout
            UserDefaults.standard.set(false, forKey: "isLoggedIn")
            UserDefaults.standard.removeObject(forKey: "token")
            UserDefaults.standard.removeObject(forKey: "userId")
            UserDefaults.standard.removeObject(forKey: "userName") // ✅ Eliminamos el nombre de UserDefaults
        }
    }
}
