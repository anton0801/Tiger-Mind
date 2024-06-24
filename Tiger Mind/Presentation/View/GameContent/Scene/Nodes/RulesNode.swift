import Foundation
import SpriteKit

class RulesNode: SKSpriteNode {
    
    private var currentRulesIndex = 0 {
        didSet {
            let action = SKAction.setTexture(SKTexture(imageNamed: "rules_data_\(currentRulesIndex + 1)"))
            currentRuleNode.run(action)
        }
    }
    
    private var currentRuleNode: SKSpriteNode = SKSpriteNode()
    private var continueButtonRules: SKSpriteNode = SKSpriteNode()
    
    var rulesEndedAction: () -> Void = {}
    
    init(size: CGSize) {
        currentRuleNode = .init(imageNamed: "rules_data_\(currentRulesIndex + 1)")
        currentRuleNode.position = CGPoint(x: 0, y: 0)
        currentRuleNode.size = size
        
        continueButtonRules = .init(imageNamed: "continue_play_button")
        continueButtonRules.position = CGPoint(x: 0, y: -155)
        
        super.init(texture: nil, color: .clear, size: size)
        
        addChild(currentRuleNode)
        addChild(continueButtonRules)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if currentRulesIndex < 1 {
            currentRulesIndex += 1
        } else {
            rulesEndedAction()
        }
    }
    
}
