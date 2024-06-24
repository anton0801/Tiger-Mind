import SpriteKit
import SwiftUI

struct GameFoundMindView: View {
    
    @Environment(\.presentationMode) var backMode
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var levelViewModel: LevelsViewModel
    var level: Level
    @State var mindScene: MindGameScene!
    @State var activeView: ActiveView = .gameView
    
    var body: some View {
        ZStack {
            if mindScene != nil {
                SpriteView(scene: mindScene)
                    .ignoresSafeArea()
            }
            
            switch (activeView) {
            case .gameView:
                EmptyView()
            case .winView:
                GameMindWinView {
                    mindScene = mindScene.restartGameView()
                    withAnimation {
                        activeView = .gameView
                    }
                }
            case .loseView:
                GameMindLoseView {
                    mindScene = mindScene.restartGameView()
                    withAnimation {
                        activeView = .gameView
                    }
                }
            case .pauseView:
                GameMindPauseView {
                    mindScene = mindScene.restartGameView()
                    withAnimation {
                        activeView = .gameView
                    }
                } continueAction: {
                    mindScene.continueGameAction()
                    withAnimation {
                        activeView = .gameView
                    }
                }
            }
        }
        .onAppear {
            mindScene = MindGameScene(level: level, loseAction: {
                withAnimation {
                    activeView = .loseView
                }
            }, winAction: {
                levelViewModel.unlockLevel(level.id + 1)
                userManager.addCoins(count: 10)
                withAnimation {
                    activeView = .winView
                }
            }, pauseAction: {
                withAnimation {
                    activeView = .pauseView
                }
            })
        }
    }
}

#Preview {
    GameFoundMindView(level: Level(id: 1, isUnlocked: true))
        .environmentObject(LevelsViewModel())
        .environmentObject(UserManager())
}

enum ActiveView {
    case gameView, winView, loseView, pauseView
}
