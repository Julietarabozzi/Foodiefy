import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color("greyBackground").edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    HStack {
                        BackButton().padding(.leading)
                        Spacer()
                    }

                    Text("Bienvenido de nuevo")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("darkGreenFoodiefy"))
                        .padding(.top, 10)

                    Image("image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                    
                    VStack(spacing: 15) {
                        TextField("Correo electrónico", text: $viewModel.email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 40)
                        
                        SecureField("Contraseña", text: $viewModel.password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .padding(.horizontal, 40)
                    }

                    if viewModel.isLoading {
                        ProgressView().padding()
                    } else {
                        Button(action: {
                            viewModel.login()
                        }) {
                            Text("Iniciar sesión")
                        }
                        .buttonStyle(FoodiefyButtonStyle())
                    }
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $viewModel.loginSuccess) {
                HomeView() // Navegar a HomeView cuando loginSuccess sea true
            }
            .navigationBarHidden(true)
        }
    }
}
