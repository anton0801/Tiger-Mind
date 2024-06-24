import SwiftUI

struct GameMindPauseView: View {
    
    @Environment(\.presentationMode) var backMode
    
    var restartAction: () -> Void
    var continueAction: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Image("cloud")
                    .offset(x: -50, y: -50)
                Image("cloud")
                    .offset(x: 50, y: 15)
                Image("pause_title")
                    .resizable()
                    .frame(width: 200, height: 100)
            }
            
            Spacer()
            
            ZStack {
                Image("auth_view_back")
                    .resizable()
                    .frame(width: 300, height: 200)
                Text("Game\non\npause")
                    .font(.custom("TL-SansSerifBold", size: 42))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            Button {
                continueAction()
            } label: {
                Image("continue_play_button")
                    .resizable()
                    .frame(width: 100, height: 80)
            }
            .offset(y: -30)
            HStack {
                Button {
                    restartAction()
                } label: {
                    Image("restart_button")
                        .resizable()
                        .frame(width: 100, height: 80)
                }
                Button {
                    backMode.wrappedValue.dismiss()
                } label: {
                    Image("home_button")
                        .resizable()
                        .frame(width: 100, height: 80)
                }
            }
            .offset(y: -30)
            
            Spacer()
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
    GameMindPauseView {
        
    } continueAction: {
        
    }
}
