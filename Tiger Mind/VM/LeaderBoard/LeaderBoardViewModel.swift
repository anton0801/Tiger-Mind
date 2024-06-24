import Foundation
import FirebaseDatabase
import FirebaseDatabaseSwift
import Combine

class LeaderBoardViewModel: ObservableObject {
    @Published var users: [UserModel] = []
    
    private var databaseRef: DatabaseReference!
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.databaseRef = Database.database().reference().child("users")
        fetchUsers()
    }
    
    func fetchUsers() {
        databaseRef.observe(.value) { snapshot in
            var fetchedUsers: [UserModel] = []
            
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String: Any],
                   let name = dict["name"] as? String,
                   let coins = dict["coins"] as? Int {
                    let email = dict["email"] as? String
                    let uid = childSnapshot.key
                    let user = UserModel(uid: uid, name: name, email: email, coins: coins)
                    fetchedUsers.append(user)
                }
            }
            
            fetchedUsers.sort(by: { $0.coins > $1.coins })
            
            DispatchQueue.main.async {
                self.users = fetchedUsers
            }
        }
    }
}
