import SwiftUI

struct ChangeUserNameView: View {
    
    @Environment(\.presentationMode) var backMode
    @EnvironmentObject var userManager: UserManager
    
    @State var newNameText = ""
    @State var changeNameError = false
    
    var body: some View {
        VStack {
            ZStack {
                Image("title_background")
                    .resizable()
                    .frame(width: 250, height: 80)
                Text("Change name")
                    .font(.custom("TL-SansSerifBold", size: 28))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            ZStack {
                Image("cloud")
                    .offset(x: -110, y: -60)
                Image("cloud")
                    .offset(x: 110, y: 60)
                
                Image("auth_view_back")
                    .resizable()
                    .frame(width: 300, height: 190)
                
                VStack {
                    TextFieldPlaceholderedView(placeholder: "New name", text: $newNameText)
                }
                .frame(width: 240)
            }
            
            Button {
                if userManager.changeUserName(newName: newNameText) {
                    backMode.wrappedValue.dismiss()
                } else {
                    withAnimation {
                        changeNameError = true
                    }
                }
            } label: {
                Image("done_button")
            }
            .offset(y: -25)
            
            if changeNameError {
                VStack {
                    Text("Some went wrong! Check new name field, it maybe is empty.")
                        .font(.custom("TL-SansSerifBold", size: 14))
                        .foregroundColor(.white)
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
                            changeNameError = false
                        }
                    }
                }
            }
            
            Spacer()
            
            Button {
                backMode.wrappedValue.dismiss()
            } label: {
                Image("home_button")
            }
            .offset(y: 40)
        }
        .background(
            Image("game_background")
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        
    }
}

#Preview {
    ChangeUserNameView()
        .environmentObject(UserManager())
}
