//
//  GameScene.swift
//  sideScroller10-25
//
//  Created by Emily on 10/25/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

//
// MARK: - PhysicsCategory Struct
//
public struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all: UInt32 = UInt32(UInt.max)
    static let playerCategory: UInt32 = 0b1
    static let rockCategory: UInt32 = 0b10
}

//
// MARK: - Enumerations
//
private enum NodeIdentifiers: String {
    case rock = "rock"
    case ground = "ground"
    case player = "player"
    case background = "background"
    case life = "life"
    case retryButton = "retryButton"
    case retryLabel = "retryLabel"
    case menuButton = "menuButton"
    case menuLabel = "menuLabel"
    case score = "score"
    case finalScore = "finalScore"
    case box = "box"
    case gameOverLabel = "gameOverLabel"

    func getZPosition() -> CGFloat {
        switch self {
        case .background:
            return 1
        case .ground,
             .life,
             .score:
            return 2
        case .rock:
            return 3
        case .player:
            return 4
        case .box:
            return 5
        case .retryButton,
             .menuButton,
             .finalScore,
             .gameOverLabel:
            return 6
        case .retryLabel,
             .menuLabel:
            return 7
        }
    }
    
    func getTexture() -> SKTexture {
        switch self {
        case .rock:
            return SKTexture(imageNamed: "rock")
        case .ground:
            return SKTexture(imageNamed: "ground")
        case .player:
            return SKTexture(imageNamed: "dino1")
        case .background:
            return SKTexture(imageNamed: "sky")
        case .life:
            return SKTexture(imageNamed: "life-icon")
        case .retryButton:
            return SKTexture(imageNamed: "button")
        case .menuButton:
            return SKTexture(imageNamed: "button")
        case .box:
            return SKTexture(imageNamed: "box")
        default:
            return SKTexture()
        }
    }
    
    func getSize() -> CGSize {
        switch self {
        case .rock:
            return CGSize( width: 180, height: 169)
        case .ground:
            return CGSize( width: 1024, height: 210)
        case .player:
            return CGSize(width: 256, height: 256)
        case .background:
            return CGSize( width: 1920, height: 1282)
        case .life:
            return CGSize(width: 106, height: 96)
        case .retryButton:
            return CGSize(width: 305, height: 96)
        case .menuButton:
            return CGSize(width: 305, height: 96)
        case .box:
            return CGSize(width: 1105, height: 667)
        default:
            return CGSize()
        }
    }
    
    func getPosition() -> CGPoint {
        switch self {
        case .rock:
            return CGPoint(x: 1900, y: 200)
        case .ground:
            return CGPoint(x: 0, y: 75)
        case .player:
            return CGPoint(x: 500, y: 275)
        case .background:
            return CGPoint(x: 960, y: 600)
        case .life:
            return CGPoint(x: 150, y: 800)
        case .retryButton:
            return CGPoint(x: 950, y: 395)
        case .retryLabel:
            return CGPoint(x: 1000, y: 380)
        case .menuButton:
            return CGPoint(x: 950, y: 245)
        case .menuLabel:
            return CGPoint(x: 1050, y: 230)
        case .score:
            return CGPoint(x: 1600, y: 800)
        case .finalScore:
            return CGPoint(x: 1110, y: 525)
        case .box:
            return CGPoint(x: 950, y: 450)
        case .gameOverLabel:
            return CGPoint(x: 1200, y: 625)
        }
    }
    
    func getText() -> String {
        switch self {
        case .retryLabel:
            return "Retry"
        case .menuLabel:
            return "Main Menu"
        case .score:
            return "Score:"
        case .finalScore:
            return "Final Score:"
        case .gameOverLabel:
            return "Game Over"
        default:
            return ""
        }
    }
    
    func getFontSize() -> CGFloat {
        switch self {
        case .retryLabel,
             .menuLabel:
            return 40
        case .score,
             .finalScore:
            return 50
        case .gameOverLabel:
            return 90
        default:
            return 0
        }
    }
    
    func getFontColor() -> UIColor {
        switch self {
        case .retryLabel,
             .menuLabel,
             .finalScore:
            return .white
        case .score:
             return .black
        case .gameOverLabel:
            return .red
        default:
            return .clear
        }
    }
}

//
// MARK: - GameScene
//
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //
    // MARK: - Nodes
    //
    private var spriteNodes: [String: SpriteNode] = [:]
    private let player = Player(texture: NodeIdentifiers.player.getTexture(), size: NodeIdentifiers.player.getSize())
    private let ground1 = Ground(texture: NodeIdentifiers.ground.getTexture(), size: NodeIdentifiers.ground.getSize())
    private let ground2 = Ground(texture: NodeIdentifiers.ground.getTexture(), size: NodeIdentifiers.ground.getSize())
    private let ground3 = Ground(texture: NodeIdentifiers.ground.getTexture(), size: NodeIdentifiers.ground.getSize())
    private let ground4 = Ground(texture: NodeIdentifiers.ground.getTexture(), size: NodeIdentifiers.ground.getSize())
    private let rock1 = Rock(texture: NodeIdentifiers.rock.getTexture(), size: NodeIdentifiers.rock.getSize())
    private let background = Background(texture: NodeIdentifiers.background.getTexture(), size: NodeIdentifiers.background.getSize())
    private let life1 = Life(texture: NodeIdentifiers.life.getTexture(), size: NodeIdentifiers.life.getSize())
    private let life2 = Life(texture: NodeIdentifiers.life.getTexture(), size: NodeIdentifiers.life.getSize())
    private let life3 = Life(texture: NodeIdentifiers.life.getTexture(), size: NodeIdentifiers.life.getSize())
    private let retryButton = Button(texture: NodeIdentifiers.retryButton.getTexture(), size: NodeIdentifiers.retryButton.getSize())
    private let menuButton = Button(texture: NodeIdentifiers.menuButton.getTexture(), size: NodeIdentifiers.menuButton.getSize())
    private let box = Box(texture: NodeIdentifiers.box.getTexture(), size: NodeIdentifiers.box.getSize())
    private let scoreLabel = LabelNode()
    private let finalScoreLabel = LabelNode()
    private let gameOverLabel = LabelNode()
    private let retryLabel = LabelNode()
    private let menuLabel = LabelNode()
    
    //
    // MARK: - Properties
    //
    private var totalLives: Int = 3
    private var gameSpeed: CGFloat = 10
    private var score: Int = 0
    private var maxTimer: Double = 5.0
    private var rockHitPlayer: Bool = false
    private var gameTimer: Timer?
    private let groundWidth: CGFloat = 1023
    private let spacer: CGFloat = 2
    private let lifeWidth: CGFloat = 106
    private let minXPos: Int = 1900
    private let maxXPos: Int = 3500
    private let minTimer: Double = 1.0
    private let groundXPos: CGFloat = 0
    private let groundYPos: CGFloat = 75
    private let groundEndPos: CGFloat = -510
    private let rockEndPos: CGFloat = -180
    private let lifeXPos: CGFloat = 150
    private let rockYPos: CGFloat = 200
    private let hudYPos: CGFloat = 800
    
    //
    // MARK: - GameScene Lifecycle
    //
    override func didMove(to view: SKView) {
        // Set physics of game scene.
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        AudioController.shared.setupGameAudio()
        AudioController.shared.setupGameOverAudio()
        
        loadGame()
        
        // Flip the even grounds so they line up.
        ground2.xScale = ground2.xScale * -1
        ground4.xScale = ground4.xScale * -1
    }
    
    // Collision detection.
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody
        
        // Disables user interaction.
        self.isUserInteractionEnabled = false
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.rockCategory != 0),
            let _ = firstBody.node as? SKSpriteNode,
            let _ = secondBody.node as? SKSpriteNode {
            player.animate(with: .hit)
            rockHitPlayer = true
            removeLife()
        }
        
        // Enables user interaction.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.isUserInteractionEnabled = true
        }
    }
    
    // Used to update all nodes.
    override func update(_ currentTime: TimeInterval) {
        
        // Update sprite nodes animations.
        for (identifier, node) in spriteNodes {
            if identifier.contains(NodeIdentifiers.rock.rawValue) {
                let didUpdate = updateRockNode(identifier: identifier, node: node)
                
                if !didUpdate {
                    if !rockHitPlayer,
                        node.position.x - 8...node.position.x + 8 ~= player.position.x {
                        score += 5
                    }
                    
                    node.animate(speed: gameSpeed)
                }
            }
            
            if identifier.contains(NodeIdentifiers.ground.rawValue) {
                node.animate(speed: gameSpeed)
            }
        }
        
        // Check all ground positions to rotate them.
        updateGroundPosition()
        
        // Update score.
        scoreLabel.updateText(text: "\(NodeIdentifiers.score.getText()) \(String(describing: score))")
    }
    
    // Detect user screen touches.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Disables user interaction.
        self.isUserInteractionEnabled = false
        
        // Play jump animation for player.
        player.animate(with: .jump)
        rockHitPlayer = false
        // Enables user interaction.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.isUserInteractionEnabled = true
        }
        
        // Used to detect button taps.
        for touch in touches {
            let location = touch.location(in: self)
            
            let touchedNode = self.atPoint(location)
            
            // Reset the game.
            if touchedNode.name == NodeIdentifiers.retryButton.rawValue || touchedNode.name == NodeIdentifiers.retryLabel.rawValue {
                resetGame()
                loadGame()
            }
            
            // Go back to the main menu.
            if touchedNode.name == NodeIdentifiers.menuButton.rawValue || touchedNode.name == NodeIdentifiers.menuLabel.rawValue {
                AudioController.shared.setupMenuAudio()
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
                }
            }
        }
    }
    
    // Load the game.
    private func loadGame() {
        // Prepare nodes for scene.
        player.prepareForScene(position: NodeIdentifiers.player.getPosition(), name: NodeIdentifiers.player.rawValue, zPosition: NodeIdentifiers.player.getZPosition())
        rock1.prepareForScene(position: NodeIdentifiers.rock.getPosition(), name: NodeIdentifiers.rock.rawValue, zPosition: NodeIdentifiers.rock.getZPosition())
        ground1.prepareForScene(position: NodeIdentifiers.ground.getPosition(), name: NodeIdentifiers.ground.rawValue, zPosition: NodeIdentifiers.ground.getZPosition())
        ground2.prepareForScene(position: CGPoint(x: ground1.position.x + groundWidth, y: groundYPos), name: NodeIdentifiers.ground.rawValue, zPosition: NodeIdentifiers.ground.getZPosition())
        ground3.prepareForScene(position: CGPoint(x: ground2.position.x + groundWidth, y: groundYPos), name: NodeIdentifiers.ground.rawValue, zPosition: NodeIdentifiers.ground.getZPosition())
        ground4.prepareForScene(position: CGPoint(x: ground3.position.x + groundWidth, y: groundYPos), name: NodeIdentifiers.ground.rawValue, zPosition: NodeIdentifiers.ground.getZPosition())
        background.prepareForScene(position: NodeIdentifiers.background.getPosition(), name: NodeIdentifiers.background.rawValue, zPosition: NodeIdentifiers.background.getZPosition())
        scoreLabel.prepareForScene(position: NodeIdentifiers.score.getPosition(), color: .black, fontSize: NodeIdentifiers.score.getFontSize(), name: NodeIdentifiers.score.rawValue, zPosition: NodeIdentifiers.score.getZPosition(), text: "\(NodeIdentifiers.score.getText()) \(String(describing: score))")
        life1.prepareForScene(position: NodeIdentifiers.life.getPosition(), name: NodeIdentifiers.life.rawValue, zPosition: NodeIdentifiers.life.getZPosition())
        life2.prepareForScene(position: CGPoint(x: lifeXPos + lifeWidth + spacer , y: hudYPos), name: NodeIdentifiers.life.rawValue, zPosition: NodeIdentifiers.life.getZPosition())
        life3.prepareForScene(position: CGPoint(x: lifeXPos + (lifeWidth * spacer) + spacer, y: hudYPos), name: NodeIdentifiers.life.rawValue, zPosition: NodeIdentifiers.life.getZPosition())
       
        // Add sprites to the spriteNodes dictionary.
        spriteNodes[NodeIdentifiers.player.rawValue] = player
        spriteNodes["\(NodeIdentifiers.rock.rawValue)1"] = rock1
        spriteNodes["\(NodeIdentifiers.ground.rawValue)1"] = ground1
        spriteNodes["\(NodeIdentifiers.ground.rawValue)2"] = ground2
        spriteNodes["\(NodeIdentifiers.ground.rawValue)3"] = ground3
        spriteNodes["\(NodeIdentifiers.ground.rawValue)4"] = ground4
        spriteNodes[NodeIdentifiers.background.rawValue] = background
        spriteNodes["\(NodeIdentifiers.life.rawValue)1"] = life1
        spriteNodes["\(NodeIdentifiers.life.rawValue)2"] = life2
        spriteNodes["\(NodeIdentifiers.life.rawValue)3"] = life3
        
        // Add nodes to scene.
        for (_, node) in spriteNodes {
            node.canAnimate = true
            addChild(node)
        }
        
        addChild(scoreLabel)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.spawnNewRock()
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(speedUpGame), userInfo: nil, repeats: true)
        AudioController.shared.playAudio(sound: AudioController.shared.gameMusic)
    }
    
    private func removeLife() {
        let nodeToRemove = spriteNodes["\(NodeIdentifiers.life.rawValue)\(String(describing: totalLives))"]
        nodeToRemove?.removeFromParent()
        spriteNodes["\(NodeIdentifiers.life.rawValue)\(String(describing: totalLives))"] = nil
        totalLives -= 1
        if totalLives == 0 {
            gameOver()
        }
    }
    
    // Remove rock node if it is off the screen.
    private func updateRockNode(identifier: String, node: SpriteNode) -> Bool {
        if node.position.x <= rockEndPos {
            node.removeFromParent()
            spriteNodes[identifier] = nil
            return true
        }
        
        return false
    }
    
    // Change ground position if it is off the screen.
    private func updateGroundPosition() {
        if ground1.position.x < groundEndPos {
            ground1.position.x = ground4.position.x + groundWidth
        }
        
        if ground2.position.x < groundEndPos {
            ground2.position.x = ground1.position.x + groundWidth
        }
        
        if ground3.position.x < groundEndPos {
            ground3.position.x = ground2.position.x + groundWidth
        }
        
        if ground4.position.x < groundEndPos {
            ground4.position.x = ground3.position.x + groundWidth
        }
    }
    
    // Spawn a new rock.
    private func spawnNewRock() {
        var rockNodes: [String: SpriteNode] = [:]
        
        for (identifier, node) in spriteNodes {
            guard node.canAnimate else {
                return
            }
            if identifier.contains(NodeIdentifiers.rock.rawValue) {
                rockNodes[identifier] = node
            }
        }
        
        // Create new rock node to be added to the game scene.
        let newRockNode = Rock(texture: NodeIdentifiers.rock.getTexture(), size: NodeIdentifiers.rock.getSize())
        var randomXPosition = Int.random(in: minXPos...maxXPos)
        
        for (id, node) in spriteNodes {
            if id.contains(NodeIdentifiers.rock.rawValue) {
                let nodeRange = (node.size.width * 4)
                if node.position.x - nodeRange...node.position.x + nodeRange ~= CGFloat(randomXPosition) {
                    randomXPosition += Int(nodeRange)
                }
            }
        }
        
        newRockNode.prepareForScene(position: CGPoint(x: CGFloat(randomXPosition), y: rockYPos), name: NodeIdentifiers.rock.rawValue, zPosition: NodeIdentifiers.rock.getZPosition())
        
        // If filteredRockNodes is not empty, a new rock identifier needs to be created else we can reuse current rock identifier.
        if rockNodes.isEmpty {
            // No other rocks are present, use the first identifier again.
            spriteNodes["\(NodeIdentifiers.rock.rawValue)1"] = newRockNode
        } else {
            
            // Other rocks are present get the next best identifier.
            var rockIdentifiers: [Int] = []
            
            for (identifier, _) in rockNodes {
                let rockIdString = identifier.dropFirst(4)
                if let rockIdNumber = Int(rockIdString) {
                    rockIdentifiers.append(rockIdNumber)
                }
            }
            
            if let maxRockId = rockIdentifiers.max() {
                let newRockId = maxRockId + 1
                let newRockIdentifier = "\(NodeIdentifiers.rock.rawValue)\(String(describing: newRockId))"
                spriteNodes[newRockIdentifier] = newRockNode
            }
        }
        
        // Set random timer for new rock spwan.
        let randomTimer = Double.random(in: minTimer...maxTimer)
        DispatchQueue.main.asyncAfter(deadline: .now() + randomTimer) {
            self.spawnNewRock()
        }
        // Add new rock to the scene.
        addChild(newRockNode)
    }
    
    // Displays game over menu and removes animations from nodes.
    private func gameOver() {
        // Cancel animations for all nodes.
        for (_, node) in spriteNodes {
            node.canAnimate = false
            node.removeAllActions()
        }
        
        // Stop playing game music.
        AudioController.shared.stopAudio(sound: AudioController.shared.gameMusic)
        AudioController.shared.playAudio(sound: AudioController.shared.gameOverSound)
        
        // Create game over nodes.
        box.prepareForScene(position: NodeIdentifiers.box.getPosition(), name: NodeIdentifiers.box.rawValue, zPosition: NodeIdentifiers.box.getZPosition())
        gameOverLabel.prepareForScene(position: NodeIdentifiers.gameOverLabel.getPosition(), color: NodeIdentifiers.gameOverLabel.getFontColor(), fontSize: NodeIdentifiers.gameOverLabel.getFontSize(), name: NodeIdentifiers.gameOverLabel.rawValue, zPosition: NodeIdentifiers.gameOverLabel.getZPosition(), text: NodeIdentifiers.gameOverLabel.getText())
        finalScoreLabel.prepareForScene(position: NodeIdentifiers.finalScore.getPosition(), color: NodeIdentifiers.finalScore.getFontColor(), fontSize: NodeIdentifiers.finalScore.getFontSize(), name: NodeIdentifiers.finalScore.rawValue, zPosition: NodeIdentifiers.finalScore.getZPosition(), text: "\(NodeIdentifiers.finalScore.getText()) \(score)")
        retryButton.prepareForScene(position: NodeIdentifiers.retryButton.getPosition(), name: NodeIdentifiers.retryButton.rawValue, zPosition: NodeIdentifiers.retryButton.getZPosition())
        retryLabel.prepareForScene(position: NodeIdentifiers.retryLabel.getPosition(), color: NodeIdentifiers.retryLabel.getFontColor(), fontSize: NodeIdentifiers.retryLabel.getFontSize(), name: NodeIdentifiers.retryLabel.rawValue, zPosition: NodeIdentifiers.retryLabel.getZPosition(), text: NodeIdentifiers.retryLabel.getText())
        menuButton.prepareForScene(position: NodeIdentifiers.menuButton.getPosition(), name: NodeIdentifiers.menuButton.rawValue, zPosition: NodeIdentifiers.menuButton.getZPosition())
        menuLabel.prepareForScene(position: NodeIdentifiers.menuLabel.getPosition(), color: NodeIdentifiers.menuLabel.getFontColor(), fontSize: NodeIdentifiers.menuLabel.getFontSize(), name: NodeIdentifiers.menuLabel.rawValue, zPosition: NodeIdentifiers.menuLabel.getZPosition(), text: NodeIdentifiers.menuLabel.getText())
        
        // Add nodes to game scene.
        addChild(retryLabel)
        addChild(retryButton)
        addChild(box)
        addChild(gameOverLabel)
        addChild(finalScoreLabel)
        addChild(menuButton)
        addChild(menuLabel)
        
        // Invalidate timer.
        gameTimer?.invalidate()
    }
    
    // Reset the game.
    private func resetGame() {
        finalScoreLabel.removeFromParent()
        gameOverLabel.removeFromParent()
        retryLabel.removeFromParent()
        retryButton.removeFromParent()
        box.removeFromParent()
        scoreLabel.removeFromParent()
        menuButton.removeFromParent()
        menuLabel.removeFromParent()
        
        for (_, node) in spriteNodes {
            node.removeFromParent()
        }
        
        spriteNodes.removeAll()
        score = 0
        totalLives = 3
        gameSpeed = 10
        maxTimer = 5.0
    }
    
    // Timer method to gradually speed up the game to increase difficulty.
    @objc private func speedUpGame() {
        gameSpeed += 1
        
        if gameSpeed == 15 {
            maxTimer = 4.0
        }
        
        if gameSpeed == 25 {
            maxTimer = 3.0
        }
    }
}

