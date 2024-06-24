import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                ZStack {
                    Image("cloud")
                        .offset(x: -50, y: -50)
                    Image("cloud")
                        .offset(x: 50, y: 15)
                    NavigationLink(destination: LeaderBoardView()
                        .navigationBarBackButtonHidden(true)) {
                        Image("liders_button")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                
                Spacer()
                
                NavigationLink(destination: LevelsViewGame()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(userManager)) {
                    Image("play_button")
                }
                
                Spacer()
                
                NavigationLink(destination: ProfileGameView()
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(userManager)) {
                    Image("settings_button")
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: StoreView(storeViewModel: StoreViewModel(userManager: userManager))
                        .navigationBarBackButtonHidden(true)) {
                            Image("store_button")
                        }
                }
                .padding()
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
    MainView()
        .environmentObject(UserManager())
}
