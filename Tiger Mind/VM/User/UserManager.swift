import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift

class UserManager: ObservableObject {
    
    @Published var user: UserModel? = nil
    @Published var selectedBackground = UserDefaults.standard.string(forKey: "map_selected") ?? "map_1" {
        didSet {
            UserDefaults.standard.set(selectedBackground, forKey: "map_selected")
        }
    }
    
    func fetchUserData(uid: String) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value) { snap in
            let value = snap.value as? NSDictionary
            if let value = value {
                self.user = UserModel(uid: uid, name: value["name"] as? String ?? "", email: value["email"] as? String ?? "", coins: value["coins"] as? Int ?? 0)
            }
        }
    }
    
    func changeUserName(newName: String) -> Bool {
        if newName.isEmpty {
            return false
        }
        
        if let user = user {
            let ref = Database.database().reference().child("users").child(user.uid)
            ref.updateChildValues(["name": newName])
            self.user = UserModel(uid: user.uid, name: newName, email: user.email, coins: user.coins)
            return true
        }
        return false
    }
    
    func addCoins(count: Int) {
        if let user = user {
            let ref = Database.database().reference().child("users").child(user.uid)
            ref.updateChildValues(["coins": user.coins + count])
            self.user = UserModel(uid: user.uid, name: user.name, email: user.email, coins: user.coins + count)
        }
    }
    
    func restCoins(count: Int) {
        if let user = user {
            let ref = Database.database().reference().child("users").child(user.uid)
            ref.updateChildValues(["coins": user.coins - count])
            self.user = UserModel(uid: user.uid, name: user.name, email: user.email, coins: user.coins - count)
        }
    }
    
}
