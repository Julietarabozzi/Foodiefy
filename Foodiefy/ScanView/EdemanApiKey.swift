import Foundation

struct APIKeys {
    static var edamamAppID: String {
        return getSecret(for: "EDAMAM_APP_ID")
    }

    static var edamamAppKey: String {
        return getSecret(for: "EDAMAM_APP_KEY")
    }

    private static func getSecret(for key: String) -> String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) else {
            print("❌ No se pudo cargar Secrets.plist")
            return ""
        }
        let value = dict[key] as? String ?? ""
        print("🔑 \(key): \(value)") // 🔹 Ver si se está leyendo bien
        return value
    }
}
