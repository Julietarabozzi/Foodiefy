import SwiftUI

// 📌 Vista principal del perfil
struct ProfileView: View {
    @EnvironmentObject var sessionManager: UserSessionManager
    @EnvironmentObject var progressViewModel: ProgressViewModel
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack {
                // 🔹 Encabezado con botón de logout
                HStack {
                    Button(action: { sessionManager.logout(progressViewModel: progressViewModel) }) {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    Text("Mi Perfil")
                        .font(.title2)
                        .bold()
                    
                    Spacer()
                    
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.top, 10)

                ScrollView {
                    VStack(spacing: 15) {
                        ProfileCard(title: "Información Personal", icon: "person.fill") {
                            ProfileTextField(title: "Nombre", text: $sessionManager.name.bound, isEditable: false)
                            ProfileTextField(title: "Edad", text: Binding(
                                get: { "\(profileViewModel.onboardingData.age)" },
                                set: { _ in }
                            ), isEditable: false)
                        }

                        // 📌 Peso y altura
                        ProfileCard(title: "Peso y Altura", icon: "scalemass.fill") {
                            HStack {
                                ProfileTextField(title: "Peso (kg)", text: Binding(
                                    get: { "\(profileViewModel.onboardingData.weight)" },
                                    set: { profileViewModel.onboardingData.weight = Double($0) ?? profileViewModel.onboardingData.weight }
                                ), isEditable: isEditing)

                                Spacer()

                                ProfileTextField(title: "Altura (cm)", text: Binding(
                                    get: { "\(profileViewModel.onboardingData.height)" },
                                    set: { profileViewModel.onboardingData.height = Double($0) ?? profileViewModel.onboardingData.height }
                                ), isEditable: isEditing)
                            }
                        }

                        ProfileCard(title: "Objetivo", icon: "target") {
                            Picker("Selecciona un objetivo", selection: $profileViewModel.onboardingData.goals) {
                                ForEach(GoalOptions.allCases, id: \.self) { goal in
                                    Text(goal.rawValue).tag(goal.rawValue)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .disabled(!isEditing)
                        }

                        ProfileCard(title: "Restricciones Alimenticias", icon: "leaf.fill") {
                            Picker("Selecciona una dieta", selection: Binding(
                                get: { profileViewModel.onboardingData.dietaryPreferences.first ?? "No tengo" },
                                set: { newValue in
                                    profileViewModel.onboardingData.dietaryPreferences = [newValue]
                                }
                            )) {
                                ForEach(DietaryPreferences.allCases, id: \.self) { diet in
                                    Text(diet.rawValue).tag(diet.rawValue)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .disabled(!isEditing)
                        }

                        ProfileCard(title: "Nivel de Actividad Física", icon: "figure.walk") {
                            Picker("Selecciona tu nivel", selection: $profileViewModel.onboardingData.activityLevel) {
                                ForEach(ActivityLevel.allCases, id: \.self) { level in
                                    Text(level.rawValue).tag(level.rawValue)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .disabled(!isEditing)
                        }
                    }
                    .padding()
                }

                Button(action: {
                    if isEditing {
                        profileViewModel.updateProfile(sessionManager: sessionManager) { success in
                            if success {
                                isEditing.toggle()
                            } else {
                                print("❌ Falló la actualización del perfil")
                            }
                        }
                    } else {
                        isEditing.toggle()
                    }
                }) {
                    Text(isEditing ? "Guardar Cambios" : "Editar Perfil")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isEditing ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            profileViewModel.loadProfile(sessionManager: sessionManager)
        }
    }
}
// 🔹 Extensión para manejar opcionales en Binding
extension Binding where Value == String? {
    var bound: Binding<String> {
        Binding<String>(
            get: { self.wrappedValue ?? "" }, // Si es nil, devuelve ""
            set: { self.wrappedValue = $0.isEmpty ? nil : $0 } // Si está vacío, lo convierte en nil
        )
    }
}
