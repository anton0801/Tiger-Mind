import Foundation

class StoreViewModel: ObservableObject {
    
    @Published var backgrounds: [Background] = []
    @Published var userManager: UserManager
    
    @Published var currentBackground: Background!
    @Published var currentBackgroundIndex = 0 {
        didSet {
            currentBackground = backgrounds[currentBackgroundIndex]
        }
    }

    init(userManager: UserManager) {
        self.userManager = userManager
        loadBackgrounds()
    }

    func buyBackground(_ background: Background) -> Bool {
        guard let index = backgrounds.firstIndex(where: { $0.id == background.id }) else {
            return false
        }
        
        if !backgrounds[index].isPurchased && (userManager.user?.coins ?? 0) >= background.price {
            userManager.restCoins(count: background.price)
            backgrounds[index].isPurchased = true
            saveBackgrounds()
            return true
        }
        return false
    }
    
    private func saveBackgrounds() {
        do {
            let encodedData = try JSONEncoder().encode(backgrounds)
            UserDefaults.standard.set(encodedData, forKey: "backgrounds")
        } catch {
        }
    }

    private func loadBackgrounds() {
        if let savedData = UserDefaults.standard.data(forKey: "backgrounds") {
            do {
                let decodedBackgrounds = try JSONDecoder().decode([Background].self, from: savedData)
                backgrounds = decodedBackgrounds
            } catch {
            }
        } else {
            backgrounds = [
                Background(id: 1, name: "map_2", price: 25),
                Background(id: 2, name: "map_3", price: 30),
                Background(id: 3, name: "map_4", price: 35),
                Background(id: 4, name: "map_5", price: 45)
            ]
            saveBackgrounds()
        }
        currentBackground = backgrounds[0]
    }
    
}
