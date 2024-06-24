import Foundation

class LevelsViewModel: ObservableObject {
    @Published var levels: [Level]
    @Published var currentPage: Int = 0
    
    let levelsPerPage = 12
    
    init() {
        self.levels = (1...24).map { Level(id: $0, isUnlocked: $0 == 1) }
        loadLevels()
    }
    
    func unlockLevel(_ id: Int) {
        if let index = levels.firstIndex(where: { $0.id == id }) {
            levels[index].isUnlocked = true
            saveLevels()
        }
    }

    
    func isLevelUnlocked(_ id: Int) -> Bool {
        guard id > 0 && id <= levels.count else { return false }
        return levels[id - 1].isUnlocked
    }
    
    func nextPage() {
        if currentPage < totalPages - 1 {
            currentPage += 1
        }
    }
    
    func previousPage() {
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    var totalPages: Int {
        return (levels.count + levelsPerPage - 1) / levelsPerPage
    }
    
    var levelsOnCurrentPage: [Level] {
        let startIndex = currentPage * levelsPerPage
        let endIndex = min(startIndex + levelsPerPage, levels.count)
        return Array(levels[startIndex..<endIndex])
    }
    
    private func loadLevels() {
        if let savedData = UserDefaults.standard.data(forKey: "levels"),
           let decodedLevels = try? JSONDecoder().decode([Level].self, from: savedData) {
            self.levels = decodedLevels
        }
    }
    
    private func saveLevels() {
        do {
            let encodedData = try JSONEncoder().encode(levels)
            UserDefaults.standard.set(encodedData, forKey: "levels")
        } catch {
        }
    }
    
}
