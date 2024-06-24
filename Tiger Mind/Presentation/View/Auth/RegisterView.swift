import SwiftUI

struct RegisterView: View {
    
    @Environment(\.presentationMode) var backMode
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var emailText: String = ""
    @State var nameText: String = ""
    @State var passwordText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    backMode.wrappedValue.dismiss()
                } label: {
                    Image("back_btn")
                        .resizable()
                        .frame(width: 42, height: 32)
                }
                Text("Register")
                    .font(.custom("TL-SansSerifBold", size: 42))
                    .foregroundColor(.black)
                    .padding(.leading)
                Spacer()
            }
            .padding()
            
            Spacer()
            
            ZStack {
                Image("auth_view_back")
                    .resizable()
                    .frame(width: 350, height: 350)
                VStack {
                    TextFieldPlaceholderedView(placeholder: "Enter your name", text: $nameText)
                    TextFieldPlaceholderedView(placeholder: "Enter email", text: $emailText)
                    SecureFieldPlaceholderedView(placeholder: "Enter password", text: $passwordText)
                }
                .frame(width: 250)
            }
            
            Button {
                authViewModel.onEvent(event: Register(email: emailText, name: nameText, password: passwordText))
            } label: {
                Image("done_button")
            }
            .offset(y: -30)
            
            if authViewModel.event is AuthEventError {
                VStack {
                    let event = authViewModel.event as? AuthEventError
                    if let event = event {
                        Text("\(event.error)")
                            .font(.custom("TL-SansSerifBold", size: 14))
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .fill(Color.init(red: 40/255, green: 56/255, blue: 32/255))
                )
                .padding()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            authViewModel.event = nil
                        }
                    }
                }
            }
            
            Spacer()
        }
        .background(
            Image("game_background")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .opacity(0.7)
        )
        .preferredColorScheme(.dark)
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthViewModel())
}
