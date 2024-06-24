import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseSwift

class AuthViewModel: ObservableObject {
    
    @Published var event: AuthEvent? = nil
    
    func onEvent(event: AuthEvent) {
        self.event = event
        switch (self.event) {
        case is AuthE:
            let eventData = event as? AuthE
            if let eventData = eventData {
                auth(email: eventData.email, password: eventData.password)
            }
        case is Register:
            let eventData = event as? Register
            if let eventData = eventData {
                register(email: eventData.email, name: eventData.name, password: eventData.password)
            }
        case is AnonymousLogiIn:
            anonymusLogIn()
        default:
            return
        }
    }
    
    private func anonymusLogIn() {
        Auth.auth().signInAnonymously { authResult, error in
            guard error == nil else {
                self.event = AuthEventError(error: "Error: \(error?.localizedDescription ?? "not defined")")
                return
            }
            
            let ref = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
            ref.setValue([
                "email": "",
                "name": "guest_\(Date().timeIntervalSince1970)",
                "credits": 0
            ])
        }
    }
    
    private func auth(email: String, password: String) {
        if email.isEmpty {
            event = AuthEventError(error: "Enter your email")
            return
        }
        if password.isEmpty {
            event = AuthEventError(error: "Enter your password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                self.event = AuthEventError(error: "Error: \(error?.localizedDescription ?? "not defined")")
                return
            }
        }
    }
    
    private func register(email: String, name: String, password: String) {
        if name.isEmpty {
            event = AuthEventError(error: "Enter your name")
            return
        }
        if email.isEmpty {
            event = AuthEventError(error: "Enter your email")
            return
        }
        if password.isEmpty {
            event = AuthEventError(error: "Create your password")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                self.event = AuthEventError(error: "Error: \(error?.localizedDescription ?? "not defined")")
                return
            }
            
            let ref = Database.database().reference().child("users").child(Auth.auth().currentUser!.uid)
            ref.setValue([
                "email": email,
                "name": name,
                "credits": 0
            ])
        }
    }
    
}

protocol AuthEvent { }

class Loading: AuthEvent { }

class AnonymousLogiIn: AuthEvent { }

struct AuthEventError: AuthEvent {
    var error: String
}

struct Register: AuthEvent {
    var email: String
    var name: String
    var password: String
}

struct AuthE: AuthEvent {
    var email: String
    var password: String
}
