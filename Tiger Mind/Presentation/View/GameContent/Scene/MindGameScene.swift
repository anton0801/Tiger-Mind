import Foundation
import SpriteKit
import SwiftUI

class MindGameScene: SKScene {
    
    private var level: Level
    private var orderItems: OrderItems
    
    var loseAction: () -> Void
    var winAction: () -> Void
    var pauseAction: () -> Void
    
    init(level: Level, loseAction: @escaping () -> Void, winAction: @escaping () -> Void, pauseAction: @escaping () -> Void) {
        self.level = level
        self.orderItems = orderItemsAll[self.level.id]!
        self.loseAction = loseAction
        self.winAction = winAction
        self.pauseAction = pauseAction
        super.init(size: CGSize(width: 750, height: 1335))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var gameMap: SKSpriteNode = SKSpriteNode()
    private var pauseButton: SKSpriteNode = SKSpriteNode()
    private var hintButton: SKSpriteNode = SKSpriteNode()
    private var rulesNode: RulesNode!
    
    private var balanceLabel: SKLabelNode = SKLabelNode(text: "")
    private var triesLabel: SKLabelNode = SKLabelNode(text: "")
    private var timeLabel: SKLabelNode = SKLabelNode(text: "")
    private var hintCountLabel: SKLabelNode = SKLabelNode(text: "")
    
    private var timePaused = false
    
    private var gameItems: [String] {
        get {
            var result = [String]()
            for i in 1...15 {
                result.append("game_item_\(i)")
            }
            return result
        }
    }
    
    private var hintNode: HintGameNode!
    
    private var orderOfItems = [String]()
    private var selectedOrderItem: [SKNode] = []
    
    private var coins = UserDefaults.standard.integer(forKey: "coins") {
        didSet {
            balanceLabel.text = "\(coins)"
            UserDefaults.standard.set(coins, forKey: "coins")
        }
    }
    
    private var tries = 3 {
        didSet {
            triesLabel.text = "\(tries)"
            if tries == 0 {
                isPaused = true
                loseAction()
            }
        }
    }
    
    private var hintCount = 2 {
        didSet {
            hintCountLabel.text = "\(hintCount)"
        }
    }
    
    private var time = 30 {
        didSet {
            if !isPaused && !timePaused {
                timeLabel.text = "\(time)"
                if time == 0 {
                    isPaused = true
                    loseAction()
                }
            }
        }
    }
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 750, height: 1335)
        gameMap = .init(imageNamed: UserDefaults.standard.string(forKey: "map_selected") ?? "map_1")
        gameMap.position = CGPoint(x: size.width / 2, y: size.height / 2)
        gameMap.size = size
        addChild(gameMap)
        
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if !self.isPaused && !self.timePaused {
                self.time -= 1
            }
        }
        
        createHeaderNodes()
        createFooter()
        
        if !UserDefaults.standard.bool(forKey: "rules_showed") {
            createRules()
            UserDefaults.standard.set(true, forKey: "rules_showed")
        } else {
            createHint()
        }
    }
    
    private func createRules() {
        rulesNode = RulesNode(size: CGSize(width: 550, height: 350))
        rulesNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        rulesNode.rulesEndedAction = {
            let actionFadeOut = SKAction.fadeOut(withDuration: 0.5)
            self.rulesNode.run(actionFadeOut) {
                self.createHint()
            }
        }
        addChild(rulesNode)
    }
    
    func restartGameView() -> MindGameScene {
        let mindSceneNew = MindGameScene(level: level, loseAction: loseAction, winAction: winAction, pauseAction: pauseAction)
        view?.presentScene(mindSceneNew)
        return mindSceneNew
    }
    
    func continueGameAction() {
        isPaused = false
    }
    
    func pauseGame() {
        isPaused = true
        pauseAction()
    }
    
    private func createHint() {
        showNowHint = true
        timePaused = true
        if hintNode == nil {
            hintNode = HintGameNode(size: CGSize(width: 600, height: 350), itemsByOrder: self.orderItems)
        }
        hintNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(hintNode)
        let actinoFadeIn = SKAction.fadeIn(withDuration: 0.5)
        hintNode.run(actinoFadeIn)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.timePaused = false
            self.showNowHint = false
            let actionFade = SKAction.fadeOut(withDuration: 0.5)
            self.hintNode.run(actionFade) {
                self.hintNode.removeFromParent()
            }
            if !self.spawnedItems {
                self.spawnAllItemsInGame()
            }
        }
    }
    
    private var spawnedItems = false
    private var showNowHint = false
    
    private func spawnAllItemsInGame() {
        var itemstoDisplay: [[String]] = []
        var temp: [String] = []
        for gameItem in gameItems {
            temp.append(gameItem)
            if temp.count == 3 {
                itemstoDisplay.append(temp)
                temp = []
            }
        }
        
        for (index, gameItemsRow) in itemstoDisplay.shuffled().enumerated() {
            for (index2, gameItem) in gameItemsRow.enumerated() {
                let gameItemNode = SKSpriteNode(imageNamed: gameItem)
                gameItemNode.name = gameItem
                let gameItemX = CGFloat(index2) * (size.width / 3) + 130
                let gameItemY = (size.height - 500) - (CGFloat(index) * 140)
                gameItemNode.size = CGSize(width: 90, height: 90)
                gameItemNode.position = CGPoint(x: gameItemX, y: gameItemY)
                addChild(gameItemNode)
                let action = SKAction.fadeIn(withDuration: 0.2)
                gameItemNode.run(action)
            }
        }
        
        spawnedItems = true
    }
    
    private func createHeaderNodes() {
        let headerBackground: SKSpriteNode = .init(imageNamed: "header_back")
        headerBackground.position = CGPoint(x: size.width / 2, y: size.height - 150)
        headerBackground.size = CGSize(width: size.width, height: 300)
        addChild(headerBackground)
        
        let balanceBackground: SKSpriteNode = .init(imageNamed: "balance_background")
        balanceBackground.position = CGPoint(x: 130, y: size.height - 100)
        balanceBackground.size = CGSize(width: 230, height: 80)
        addChild(balanceBackground)
        
        balanceLabel = .init(text: "\(coins)")
        balanceLabel.fontName = "TL-SansSerifBold"
        balanceLabel.fontSize = 32
        balanceLabel.fontColor = .white
        balanceLabel.position = CGPoint(x: 90, y: size.height - 110)
        addChild(balanceLabel)
        
        let triesBackground: SKSpriteNode = .init(imageNamed: "tries_background")
        triesBackground.position = CGPoint(x: size.width - 130, y: size.height - 100)
        triesBackground.size = CGSize(width: 230, height: 80)
        addChild(triesBackground)
        
        triesLabel = .init(text: "\(tries)")
        triesLabel.fontName = "TL-SansSerifBold"
        triesLabel.fontSize = 32
        triesLabel.fontColor = .white
        triesLabel.position = CGPoint(x: size.width - 170, y: size.height - 110)
        addChild(triesLabel)
        
        let timeBackground: SKSpriteNode = .init(imageNamed: "time_background")
        timeBackground.position = CGPoint(x: size.width / 2, y: size.height - 325)
        timeBackground.size = CGSize(width: 220, height: 80)
        addChild(timeBackground)
        
        timeLabel = .init(text: "\(time)")
        timeLabel.fontName = "TL-SansSerifBold"
        timeLabel.fontSize = 40
        timeLabel.fontColor = .white
        timeLabel.position = CGPoint(x: size.width / 2 + 30, y: size.height - 340)
        addChild(timeLabel)
    }
    
    private func createFooter() {
        pauseButton = .init(imageNamed: "pause_button")
        pauseButton.position = CGPoint(x: 140, y: 70)
        pauseButton.size = CGSize(width: pauseButton.size.width * 1.8, height: pauseButton.size.height * 1.4)
        addChild(pauseButton)
        
        hintButton = .init(imageNamed: "hint_button")
        hintButton.position = CGPoint(x: size.width - 140, y: 70)
        hintButton.size = CGSize(width: hintButton.size.width * 1.8, height: hintButton.size.height * 1.4)
        addChild(hintButton)
        
        let hintBackgroundCount: SKSpriteNode = .init(imageNamed: "count_background")
        hintBackgroundCount.position = CGPoint(x: hintButton.position.x + 80, y: hintButton.position.y - 40)
        addChild(hintBackgroundCount)
        
        hintCountLabel = .init(text: "\(hintCount)")
        hintCountLabel.fontName = "TL-SansSerifBold"
        hintCountLabel.fontSize = 24
        hintCountLabel.fontColor = .white
        hintCountLabel.position = CGPoint(x: hintBackgroundCount.position.x, y: hintBackgroundCount.position.y - 8)
        addChild(hintCountLabel)
        
        let levelBg: SKSpriteNode = .init(imageNamed: "level_bg")
        levelBg.position = CGPoint(x: size.width / 2, y: 40)
        addChild(levelBg)
        
        let levelLabel: SKLabelNode = .init(text: "LVL \(level.id)")
        levelLabel.fontName = "TL-SansSerifBold"
        levelLabel.fontSize = 20
        levelLabel.fontColor = .white
        levelLabel.position = CGPoint(x: size.width / 2, y: 35)
        addChild(levelLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let nodes = nodes(at: location)
            
            if nodes.contains(pauseButton) {
                pauseGame()
                return
            }
            
            if nodes.contains(hintButton) && !showNowHint {
                if hintCount > 0 {
                    createHint()
                    hintCount -= 1
                }
                return
            }
            
            for node in nodes {
                let name = node.name
                if let name = name {
                    if name.contains("game_item") == true {
                        orderOfItems.append(name)
                        selectedOrderItem.append(node)
                        checkOrderOfItems()
                    }
                }
            }
        }
    }
    
    private func checkOrderOfItems() {
        for (index, item) in orderOfItems.enumerated() {
            let correctOrderOfItem = orderItems.order[item]
            if let correctOrderOfItem = correctOrderOfItem {
                if (index + 1) != correctOrderOfItem {
                    tries -= 1
                    let actionAlphaAll = SKAction.fadeAlpha(to: 1, duration: 0.3)
                    for n in selectedOrderItem {
                        n.run(actionAlphaAll)
                    }
                    selectedOrderItem = []
                    orderOfItems = []
                    return
                }
                let actionAlpha = SKAction.fadeAlpha(to: 0.6, duration: 0.3)
                selectedOrderItem[index].run(actionAlpha)
            } else {
                tries -= 1
                let actionAlphaAll = SKAction.fadeAlpha(to: 1, duration: 0.3)
                for n in selectedOrderItem {
                    n.run(actionAlphaAll)
                }
                selectedOrderItem = []
                orderOfItems = []
                return
            }
        }
        if orderOfItems.count != orderItems.items.count {
            return
        }
        
        isPaused = true
        winAction()
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: MindGameScene(level: Level(id: 1, isUnlocked: true), loseAction: { }, winAction: { }, pauseAction: { }))
            .ignoresSafeArea()
    }
}
