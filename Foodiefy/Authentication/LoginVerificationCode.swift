//
//  LoginVerificationCode.swift
//  Foodiefy
//
//  Created by Julieta Rabozzi on 04/03/2025.
//

import Foundation
import SwiftUI

struct VerificationLoginCodeView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var sessionManager: UserSessionManager
    @State private var errorMessage: String?

    let email: String

    var body: some View {
        VStack(spacing: 20) {
            Spacer()

            Text("Verificación de Código")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color("darkGreenFoodiefy"))

            Text("Ingresa el código de verificación enviado a tu correo electrónico.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            TextField("Código de verificación", text: $viewModel.verificationCode)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.footnote)
                    .padding(.top, 5)
            }

            Button("Confirmar") {
                verifyCode()
            }
            .buttonStyle(FoodiefyButtonStyle())
            .disabled(viewModel.verificationCode.isEmpty)
            .opacity(viewModel.verificationCode.isEmpty ? 0.5 : 1)
            .padding(.horizontal, 40)

            Spacer()
        }
        .padding()
        .modifier(NavigationBackModifier(color: Color("darkViolet")))
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("📩 Email recibido en VerificationLoginCodeView: \(email)")
            viewModel.email = email
        }
    }

    private func verifyCode() {
        viewModel.verifyLoginCode(sessionManager: sessionManager) { success in
            if success {
                router.navigate(to: .home)
            } else {
                errorMessage = "Código incorrecto. Inténtalo nuevamente."
            }
        }
    }
}
