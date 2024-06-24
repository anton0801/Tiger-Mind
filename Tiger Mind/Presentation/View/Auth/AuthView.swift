import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State var emailText: String = ""
    @State var passwordText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Authorize")
                        .font(.custom("TL-SansSerifBold", size: 42))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                ZStack {
                    Image("auth_view_back")
                    VStack {
                        TextFieldPlaceholderedView(placeholder: "Enter email", text: $emailText)
                        SecureFieldPlaceholderedView(placeholder: "Enter password", text: $passwordText)
                    }
                    .frame(width: 250)
                }
                
                Button {
                    authViewModel.onEvent(event: AuthE(email: emailText, password: passwordText))
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
                
                NavigationLink(destination: RegisterView()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(authViewModel)) {
                        Text("Not have an account? Register")
                            .font(.custom("TL-SansSerifBold", size: 24))
                            .foregroundColor(.white)
                            .underline()
                    }
            
                Text("OR")
                    .font(.custom("TL-SansSerifBold", size: 24))
                    .foregroundColor(.white)
                
                Button {
                    authViewModel.onEvent(event: AnonymousLogiIn())
                } label: {
                    ZStack {
                        Image("button_background")
                        Text("Sign in anonymusly")
                            .font(.custom("TL-SansSerifBold", size: 24))
                            .foregroundColor(.white)
                    }
                }
                
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    AuthView()
        .environmentObject(AuthViewModel())
}
