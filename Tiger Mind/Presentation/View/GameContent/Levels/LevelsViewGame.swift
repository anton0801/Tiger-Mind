import SwiftUI

struct LevelsViewGame: View {
    
    @Environment(\.presentationMode) var backMode
    @EnvironmentObject var userManager: UserManager
    @StateObject private var viewModel = LevelsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Image("play_title")
                
                if viewModel.currentPage == 0 {
                    Button {
                        withAnimation {
                            viewModel.nextPage()
                        }
                    } label: {
                        Image("arrow_right_button")
                    }
                    .padding(.top)
                } else {
                    Button {
                        withAnimation {
                            viewModel.previousPage()
                        }
                    } label: {
                        Image("arrow_left_button")
                    }
                    .padding(.top)
                }
                
                Spacer()
                
                LazyVGrid(columns: [
                    GridItem(.fixed(80), spacing: 32),
                    GridItem(.fixed(80), spacing: 32),
                    GridItem(.fixed(80), spacing: 32),
                ]) {
                    ForEach(viewModel.levelsOnCurrentPage, id: \.id) { level in
                        if level.isUnlocked {
                            NavigationLink(destination: GameFoundMindView(level: level)
                                .navigationBarBackButtonHidden(true)
                                .environmentObject(userManager)
                                .environmentObject(viewModel)) {
                                    ZStack {
                                        Image("level_background")
                                        Text("\(level.id)")
                                            .font(.custom("TL-SansSerifBold", size: 24))
                                            .foregroundColor(.white)
                                    }
                                }
                        } else {
                            ZStack {
                                Image("level_background")
                                Text("\(level.id)")
                                    .font(.custom("TL-SansSerifBold", size: 24))
                                    .foregroundColor(.white)
                            }
                            .opacity(0.7)
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    LevelsViewGame()
        .environmentObject(UserManager())
}
