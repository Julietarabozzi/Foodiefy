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
    var isSecure: Bool = false

    var body: some View {
        Group {
            if isSecure {
                SecureField(placeholder, text: $text)
                    .textFieldStyle()
            } else {
                TextField(placeholder, text: $text)
                    .textFieldStyle()
            }
        }
        .padding(.horizontal, 40)
    }
}

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
