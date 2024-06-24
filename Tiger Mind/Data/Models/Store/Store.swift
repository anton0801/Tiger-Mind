import Foundation

struct Background: Identifiable, Codable {
    let id: Int
    let name: String
    let price: Int
    var isPurchased: Bool = false
}
