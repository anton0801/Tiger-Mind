import SwiftUI

struct StoreView: View {
    
    @StateObject var storeViewModel: StoreViewModel
    
    @State var errorPurchase = false
    
    var body: some View {
        VStack {
            ZStack {
                Image("header_back")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 200)
                HStack {
                    Button {
                        withAnimation {
                            storeViewModel.currentBackgroundIndex -= 1
                        }
                    } label: {
                        Image("arrow_left_button")
                            .resizable()
                            .frame(width: 80, height: 70)
                    }
                    .opacity(storeViewModel.currentBackgroundIndex == 0 ? 0.6 : 1)
                    .disabled(storeViewModel.currentBackgroundIndex == 0 ? true : false)
                    
                    Spacer()
                    
                    Button {
                        withAnimation {
                            storeViewModel.currentBackgroundIndex += 1
                        }
                    } label: {
                        Image("arrow_right_button")
                            .resizable()
                            .frame(width: 80, height: 70)
                    }
                    .opacity(storeViewModel.currentBackgroundIndex == storeViewModel.backgrounds.count - 1 ? 0.6 : 1)
                    .disabled(storeViewModel.currentBackgroundIndex == storeViewModel.backgrounds.count - 1 ? true : false)
                }
                .offset(y: -50)
            }
            .ignoresSafeArea()
            
            ZStack {
                Image("balance_background")
                Text("\(storeViewModel.currentBackground.price)")
                    .font(.custom("TL-SansSerifBold", size: 32))
                    .foregroundColor(.white)
                    .padding(.trailing, 42)
            }
            .offset(y: -120)
            
            Spacer()
            
            if storeViewModel.currentBackground.isPurchased {
                if storeViewModel.userManager.selectedBackground != storeViewModel.currentBackground.name {
                    Button {
                        storeViewModel.userManager.selectedBackground = storeViewModel.currentBackground.name
                    } label: {
                        Image("done_button")
                            .resizable()
                            .frame(width: 80, height: 60)
                    }
                }
            } else {
                Button {
                    errorPurchase = !storeViewModel.buyBackground(storeViewModel.currentBackground)
                } label: {
                    Image("store_button")
                        .resizable()
                        .frame(width: 80, height: 60)
                }
            }
            
            ZStack {
                Image("level_bg")
                    .resizable()
                    .frame(width: 180, height: 80)
                Text("MAP")
                    .font(.custom("TL-SansSerifBold", size: 32))
                    .foregroundColor(.white)
            }
            .offset(y: 30)
        }
        .background(
            Image(storeViewModel.currentBackground.name)
                .resizable()
                .frame(minWidth: UIScreen.main.bounds.width, minHeight: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
        .alert(isPresented: $errorPurchase) {
            Alert(title: Text("Error purchase"),
            message: Text("Someting went wrong! It looks like you don't have enough coins to purchase this background."),
                  dismissButton: .cancel(Text("OK")))
        }
    }
}

#Preview {
    StoreView(storeViewModel: StoreViewModel(userManager: UserManager()))
}
