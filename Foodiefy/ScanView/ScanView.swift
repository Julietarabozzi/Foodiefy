import SwiftUI

struct ScanView: View {
    @ObservedObject var viewModel: FoodScannerViewModel

    var body: some View {
        ZStack {
            Color("greyBackground")
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                Spacer()

                // Ícono de la foto
                Image(systemName: "camera.viewfinder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.blue)

                Text("Presiona para escanear")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                NavigationLink(destination: ARScannerView(viewModel: viewModel)) {
                    Text("Escanear")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(Color("darkGreenFoodiefy"))
                        .cornerRadius(100)
                        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
                        .padding(.horizontal, 40)
                }

                if viewModel.isLoading {
                    ProgressView()
                }

                if let nutrients = viewModel.nutrients {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("🍏 \(viewModel.foodName)").font(.headline)
                        Text("🔥 Calorías: \(nutrients.ENERC_KCAL ?? 0) kcal")
                        Text("💪 Proteínas: \(nutrients.PROCNT ?? 0) g")
                        Text("🥑 Grasas: \(nutrients.FAT ?? 0) g")
                        Text("🍞 Carbohidratos: \(nutrients.CHOCDF ?? 0) g")
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }

                if let errorMessage = viewModel.errorMessage {
                    Text("⚠️ \(errorMessage)").foregroundColor(.red)
                }

                Spacer()
            }
        }
        .navigationTitle("Escaneo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
