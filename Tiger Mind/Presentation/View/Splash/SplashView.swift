import SwiftUI
import FirebaseAuth

struct SplashView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject var userManager: UserManager = UserManager()
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    @State var autorizedUserGoToMainView = false
    @State var notAutorizedUserGoToAuthView = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Loading data...")
                        .font(.custom("TL-SansSerifBold", size: 42))
                        .foregroundColor(.white)
                }
                .padding()
                
                NavigationLink(destination: AuthView()
                    .environmentObject(authViewModel)
                    .navigationBarBackButtonHidden(true), isActive: $notAutorizedUserGoToAuthView) {
                        EmptyView()
                    }
                
                NavigationLink(destination: MainView()
                    .environmentObject(userManager)
                    .navigationBarBackButtonHidden(true), isActive: $autorizedUserGoToMainView) {
                        EmptyView()
                    }
            }
            .background(
                Image("game_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if (auth.currentUser == nil) {
                        notAutorizedUserGoToAuthView = true
                    } else {
                        userManager.fetchUserData(uid: auth.currentUser!.uid)
                        autorizedUserGoToMainView = true
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    SplashView()
        .environmentObject(AuthViewModel())
}
