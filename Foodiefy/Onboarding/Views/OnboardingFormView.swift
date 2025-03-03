import SwiftUI

struct OnboardingFormView: View {
    @EnvironmentObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""

    var body: some View {
        ZStack {
            Color("greyBackground").edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                Spacer()
                OnboardingHeaderView()
                Spacer()
                OnboardingFormFieldsView(age: $age, weight: $weight, height: $height)
                Spacer()
                OnboardingNextButtonView(viewModel: viewModel, age: age, weight: weight, height: height)
                    .environmentObject(router)

                Spacer()
            }
        }
    }
}

private struct OnboardingHeaderView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Cuéntanos sobre ti")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(.darkGreenFoodiefy))
        }
    }
}

private struct OnboardingFormFieldsView: View {
    @Binding var age: String
    @Binding var weight: String
    @Binding var height: String

    var body: some View {
        VStack(spacing: 15) {
            FoodiefyTextField(placeholder: "Edad", text: $age)
                .keyboardType(.numberPad)
            FoodiefyTextField(placeholder: "Peso (kg)", text: $weight)
                .keyboardType(.decimalPad)

            FoodiefyTextField(placeholder: "Altura (cm)", text: $height)
                .keyboardType(.decimalPad)
        }
        .padding(.horizontal, 40)
    }
}

private struct OnboardingNextButtonView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject var router: AppRouter
    var age: String
    var weight: String
    var height: String

    var body: some View {
        Button(action: {
            viewModel.age = age
            viewModel.weight = weight
            viewModel.height = height
            router.navigate(to: .goalsForm)
        }) {
            Text("Siguiente")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(FoodiefyButtonStyle())
        .padding(.horizontal, 40)
        .disabled(!viewModel.isFormValid(age: age, weight: weight, height: height))
        .opacity(viewModel.isFormValid(age: age, weight: weight, height: height) ? 1 : 0.5)
    }
}

#Preview{
    OnboardingFormView()
        .environmentObject(OnboardingViewModel())
        .environmentObject(AppRouter())
}
