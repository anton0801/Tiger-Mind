import SwiftUI

struct LeaderBoardUserItemView: View {
    
    var user: UserModel
    
    var body: some View {
        HStack {
            ZStack {
                Image("leader_value_bg")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                Text(user.name)
                    .font(.custom("TL-SansSerifBold", size: 20))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            
            ZStack {
                Image("leader_value_bg")
                    .resizable()
                    .frame(width: 100, height: 50)
                HStack {
                    Text("\(user.coins)")
                        .font(.custom("TL-SansSerifBold", size: 20))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Image("coin")
                }
            }
        }
        .padding()
    }
}

#Preview {
    LeaderBoardUserItemView(user: UserModel(uid: "test", name: "UserName", email: "test@gmail.com", coins: 100))
}
