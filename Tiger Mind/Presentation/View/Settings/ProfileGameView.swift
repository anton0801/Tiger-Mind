import SwiftUI

struct ProfileGameView: View {
    
    @Environment(\.presentationMode) var backMode
    @EnvironmentObject var userManager: UserManager
    
    @State var soundsOn = UserDefaults.standard.bool(forKey: "sounds_on_in_app")
    
    var body: some View {
        NavigationView {
            VStack {
                Image("settings_title")
                
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
                        HStack {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 52, height: 52)
                            Text("\(userManager.user?.name ?? "undefined_name")")
                                .font(.custom("TL-SansSerifBold", size: 16))
                                .foregroundColor(.white)
                                .padding(.leading, 6)
                                .frame(width: 90)
                        }
                        NavigationLink(destination: ChangeUserNameView()
                            .navigationBarBackButtonHidden(true)
                            .environmentObject(userManager)) {
                                Text("Change name")
                                    .font(.custom("TL-SansSerifBold", size: 16))
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                                    .background(
                                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                                            .fill(Color.init(red: 40/255, green: 56/255, blue: 32/255))
                                    )
                            }
                    }
                }
                
                Spacer()
                
                ZStack {
                    Image("auth_view_back")
                        .resizable()
                        .frame(width: 300, height: 150)
                    
                    VStack {
                        HStack {
                            Image("sounds")
                            Button {
                                withAnimation {
                                    soundsOn = !soundsOn
                                }
                            } label: {
                                if soundsOn {
                                    Image("sounds_enabled")
                                } else {
                                    Image("sounds_disabled")
                                }
                            }
                        }
                    }
                }
                
                Button {
                    UserDefaults.standard.set(soundsOn, forKey: "sounds_on_in_app")
                    backMode.wrappedValue.dismiss()
                } label: {
                    Image("done_button")
                }
                .offset(y: -25)
                
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ProfileGameView()
        .environmentObject(UserManager())
}
