import SwiftUI

struct NavigationBackModifier: ViewModifier {
    @Environment(\.presentationMode) var presentationMode

    var color: Color = Color("darkViolet")

    func body(content: Content) -> some View {
        content
            .overlay(
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.backward")
                            .foregroundColor(color)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.leading)
                    }
                    Spacer()
                },
                alignment: .topLeading
            )
    }
}
