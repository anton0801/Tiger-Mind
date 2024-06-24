import Foundation
import SpriteKit

class HintGameNode: SKSpriteNode {
    
    var itemNodes: [SKSpriteNode] = []
    
    init(size: CGSize, itemsByOrder: OrderItems) {
        super.init(texture: nil, color: .clear, size: size)
        
        let background: SKSpriteNode = .init(imageNamed: "game_items_bg")
        background.position = CGPoint(x: 0, y: 0)
        background.size = size
        addChild(background)
        
        configureWithItems(itemsByOrder.items)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithItems(_ items: [String]) {
       itemNodes.forEach { $0.removeFromParent() }
       itemNodes.removeAll()
       
       for imageName in items {
           let item = SKSpriteNode(imageNamed: imageName)
           item.name = imageName
           itemNodes.append(item)
           addChild(item)
       }
       
       layoutItems()
   }
   
    private func layoutItems() {
        guard itemNodes.count > 0 else { return }
        
        let rows = 2
        let cols = (itemNodes.count + 1) / rows
        
        let containerWidth = size.width
        let containerHeight = size.height
        
        let maxItemWidth: CGFloat = 120
        let maxItemHeight: CGFloat = 120
        
        let itemWidth = min(containerWidth / CGFloat(cols), maxItemWidth)
        let itemHeight = min(containerHeight / CGFloat(rows), maxItemHeight)
        
        let totalWidth = itemWidth * CGFloat(cols)
        let totalHeight = itemHeight * CGFloat(rows)
        
        let spacingX = (containerWidth - totalWidth) / CGFloat(cols + 1)
        let spacingY = (containerHeight - totalHeight) / CGFloat(rows + 1)
        
        for (index, item) in itemNodes.enumerated() {
            let row = index / cols
            let col = index % cols
            
            let xPosition = (-containerWidth / 2) + spacingX + CGFloat(col) * (itemWidth + spacingX) + itemWidth / 2
            let yPosition = (containerHeight / 2) - spacingY - CGFloat(row) * (itemHeight + spacingY) - itemHeight / 2
            
            item.size = CGSize(width: itemWidth, height: itemHeight)
            item.position = CGPoint(x: xPosition, y: yPosition)
        }
    }
    
}
