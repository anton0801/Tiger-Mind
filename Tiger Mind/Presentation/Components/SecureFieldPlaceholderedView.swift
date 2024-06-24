import SwiftUI

struct SecureFieldPlaceholderedView: View {
    
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            SecureField("", text: $text)
                .padding()
                .font(.custom("TL-SansSerifBold", size: 18))
                .background(Color.init(red: 40/255, green: 56/255, blue: 32/255))
                .cornerRadius(10)
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                )
                .padding(.horizontal)
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white)
                    .font(.custom("TL-SansSerifBold", size: 18))
                    .padding(.leading, 30)
            }
        }
    }
}


#Preview {
    SecureFieldPlaceholderedView(placeholder: "Text", text: .constant(""))
}
