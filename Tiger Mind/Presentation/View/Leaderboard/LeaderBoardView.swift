import SwiftUI

struct LeaderBoardView: View {
    
    @Environment(\.presentationMode) var backMode
    @StateObject private var viewModel = LeaderBoardViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Image("cloud")
                    .offset(x: -50, y: -50)
                Image("cloud")
                    .offset(x: 50, y: 15)
                Image("leader_title")
            }
            Spacer()
            ZStack {
                Image("leaders_background")
                if viewModel.users.isEmpty {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack {
                            ForEach(viewModel.users, id: \.uid) { user in
                                LeaderBoardUserItemView(user: user)
                            }
                        }
                    }
                    .frame(width: 250, height: 350)
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
    LeaderBoardView()
}
