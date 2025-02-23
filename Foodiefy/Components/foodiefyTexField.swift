//
//  foodiefyTexField.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 09/02/2025.
//

import Foundation
import SwiftUI

struct FoodiefyTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle()
            .padding(.horizontal, 40)
    }
}

// 🔹 TextField específico para contraseñas con icono de ojo
struct FoodiefyPasswordField: View {
    var placeholder: String
    @Binding var text: String
    @State private var isSecure: Bool = true

    var body: some View {
        HStack {
            if isSecure {
                SecureField(placeholder, text: $text)
            } else {
                TextField(placeholder, text: $text)
            }
            Button(action: { isSecure.toggle() }) {
                Image(systemName: isSecure ? "eye.slash.fill" : "eye.fill")
                    .foregroundColor(.gray)
            }
        }
        .textFieldStyle()
        .padding(.horizontal, 40)
    }
}

// 🔹 Extensión para aplicar un estilo unificado
extension View {
    func textFieldStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.vertical, 5)
    }
}
