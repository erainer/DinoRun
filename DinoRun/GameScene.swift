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
struct PhysicsCategory {
    static let none : UInt32 = 0
    static let all: UInt32 = UInt32(UInt.max)
    static let playerCategory: UInt32 = 0b1
    static let rockCategory: UInt32 = 0b10
}

//
// MARK: - Enumerations
//
enum SpriteIdentifiers: String {
    case rock = "rock"
    case ground = "ground"
    case player = "player"
    case background = "background"
    case life = "life"
}

enum GameText: String {
    case score = "Score:"
    case gameOver = "Game Over"
    case finalScore = "Final Score:"
    case retry = "Retry"
    case menu = "Main Menu"
}
//
// MARK: - GameScene
//
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //
    // MARK: - Nodes
    //
    var spriteNodes: [String: SpriteNode] = [:]
    let player = Player()
    let ground1 = Ground()
    let ground2 = Ground()
    let ground3 = Ground()
    let ground4 = Ground()
    let rock1 = Rock()
    let rock2 = Rock()
    let background = Background()
    let life1 = Life()
    let life2 = Life()
    let life3 = Life()
    let retryButton = Button()
    let menuButton = Button()
    let scoreLabel = Label()
    let finalScoreLabel = Label()
    let gameOverLabel = Label()
    let retryLabel = Label()
    let menuLabel = Label()
    let box = Box()
    
    //
    // MARK: - Properties
    //
    var totalLives: Int = 3
    var gameSpeed: CGFloat = 10
    var score: Int = 0
    var maxTimer: Double = 5.0
    var rockHitPlayer: Bool = false
    var gameTimer: Timer?
    
    let groundWidth: CGFloat = 1023
    let groundSpacer: CGFloat = 2
    let lifeWidth: CGFloat = 106
    let minXPos: Int = 1900
    let maxXPos: Int = 3500
    let minTimer: Double = 1.0
    
    // Positions
    let backgroundXPos: CGFloat = 960
    let backgroundYPos: CGFloat = 600
    let rockXPos: CGFloat = 1900
    let rockYPos: CGFloat = 200
    let groundXPos: CGFloat = 0
    let groundYPos: CGFloat = 75
    let groundEndPos: CGFloat = -510
    let rockEndPos: CGFloat = -180
    let playerXPos: CGFloat = 500
    let playerYPos: CGFloat = 275
    let scoreXPos: CGFloat = 1600
    let hudYPos: CGFloat = 800
    let lifeXPos: CGFloat = 150
    let gameOverXPos: CGFloat = 1200
    let gameOverYPos: CGFloat = 625
    
    //
    // MARK: - GameScene Lifecycle
    //
    override func didMove(to view: SKView) {
        // Set physics of game scene.
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        loadGame()
        
        // Flip the even grounds so they line up.
        ground2.xScale = ground2.xScale * -1
        ground4.xScale = ground4.xScale * -1
    }
    
    // Timer method to gradually speed up the game to increase difficulty.
    @objc func speedUpGame() {
        gameSpeed += 1
        
        if gameSpeed == 15 {
            maxTimer = 4.0
        }
        
        if gameSpeed == 25 {
            maxTimer = 3.0
        }
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
            if touchedNode.name == "retryButton" || touchedNode.name == "retryLabel" {
                resetGame()
                loadGame()
            }
            
            // Go back to the main menu.
            if touchedNode.name == "menuButton" || touchedNode.name == "menuLabel" {
                AudioController.shared.setupMenuAudio()
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
                    (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
                }
                
            }
        }
    }
    
    // Reset the game.
    func resetGame() {
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
    
    // Load the game.
    func loadGame() {
        // Create Nodes.
        player.create(position: CGPoint(x: playerXPos, y: playerYPos))
        rock1.create(position: CGPoint(x: rockXPos, y: rockYPos))
        ground1.create(position: CGPoint(x: groundXPos, y: groundYPos))
        ground2.create(position: CGPoint(x: ground1.position.x + groundWidth, y: groundYPos))
        ground3.create(position: CGPoint(x: ground2.position.x + groundWidth, y: groundYPos))
        ground4.create(position: CGPoint(x: ground3.position.x + groundWidth, y: groundYPos))
        background.create(position: CGPoint(x: backgroundXPos, y: backgroundYPos))
        scoreLabel.create(position: CGPoint(x: scoreXPos, y: hudYPos), text: "\(GameText.score.rawValue) \(String(describing: score))")
        life1.create(position: CGPoint(x: lifeXPos, y: hudYPos))
        life2.create(position: CGPoint(x: lifeXPos + lifeWidth + groundSpacer , y: hudYPos))
        life3.create(position: CGPoint(x: lifeXPos + (lifeWidth * groundSpacer) + groundSpacer, y: hudYPos))
        
        // Add sprites to the spriteNodes dictionary.
        spriteNodes[SpriteIdentifiers.player.rawValue] = player
        spriteNodes["\(SpriteIdentifiers.rock.rawValue)1"] = rock1
        spriteNodes["\(SpriteIdentifiers.ground.rawValue)1"] = ground1
        spriteNodes["\(SpriteIdentifiers.ground.rawValue)2"] = ground2
        spriteNodes["\(SpriteIdentifiers.ground.rawValue)3"] = ground3
        spriteNodes["\(SpriteIdentifiers.ground.rawValue)4"] = ground4
        spriteNodes[SpriteIdentifiers.background.rawValue] = background
        spriteNodes["\(SpriteIdentifiers.life.rawValue)1"] = life1
        spriteNodes["\(SpriteIdentifiers.life.rawValue)2"] = life2
        spriteNodes["\(SpriteIdentifiers.life.rawValue)3"] = life3
        
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
    }
    
    // Used to update all nodes.
    override func update(_ currentTime: TimeInterval) {
        
        // Update sprite nodes animations.
        for (identifier, node) in spriteNodes {
            if identifier.contains(SpriteIdentifiers.rock.rawValue) {
                let didUpdate = updateRockNode(identifier: identifier, node: node)
                
                if !didUpdate {
                    if !rockHitPlayer,
                        node.position.x - 8...node.position.x + 8 ~= player.position.x {
                        score += 5
                    }
                    
                    node.animate(speed: gameSpeed)
                }
            }
            
            if identifier.contains(SpriteIdentifiers.ground.rawValue) {
                node.animate(speed: gameSpeed)
            }
        }
        
        // Check all ground positions to rotate them.
        updateGroundPosition()
        
        // Update score.
        scoreLabel.updateText(text: "\(GameText.score.rawValue) \(String(describing: score))")
    }
    
    func removeLife() {
        let nodeToRemove = spriteNodes["\(SpriteIdentifiers.life.rawValue)\(String(describing: totalLives))"]
        nodeToRemove?.removeFromParent()
        spriteNodes["\(SpriteIdentifiers.life.rawValue)\(String(describing: totalLives))"] = nil
        totalLives -= 1
        if totalLives == 0 {
            gameOver()
        }
    }
    
    // Displays game over menu and removes animations from nodes.
    func gameOver() {
        // Cancel animations for all nodes.
        for (_, node) in spriteNodes {
            node.canAnimate = false
            node.removeAllActions()
        }
        
        // Stop playing game audio and play game over audio.
        AudioController.shared.stopAudio(sound: AudioController.shared.gameMusic)
        AudioController.shared.setupGameOverAudio()
        
        // Create game over nodes.
        box.create(position: CGPoint(x: 950, y: 450))
        gameOverLabel.create(position: CGPoint(x: gameOverXPos, y: gameOverYPos), color: .red, text: GameText.gameOver.rawValue)
        gameOverLabel.fontSize = 90
        finalScoreLabel.create(position: CGPoint(x: gameOverXPos - 90, y: gameOverYPos - 100), color: .white, text: "\(GameText.finalScore.rawValue) \(String(describing: score))")
        finalScoreLabel.fontSize = 50
        retryButton.create(position: CGPoint(x: gameOverXPos - 250, y: gameOverYPos - 230))
        retryButton.name = "retryButton"
        retryLabel.create(position: CGPoint(x: gameOverXPos - 200, y: gameOverYPos - 245), color: .white, text: GameText.retry.rawValue)
        retryLabel.name = "retryLabel"
        retryLabel.zPosition = 8
        retryLabel.fontSize = 40
        menuButton.create(position: CGPoint(x: gameOverXPos - 250, y: gameOverYPos - 380))
        menuButton.name = "menuButton"
        menuLabel.create(position: CGPoint(x: gameOverXPos - 150, y: gameOverYPos - 395), color: .white, text: GameText.menu.rawValue)
        menuLabel.name = "menuLabel"
        menuLabel.zPosition = 8
        menuLabel.fontSize = 40
        
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
    
    // Remove rock node if it is off the screen.
    func updateRockNode(identifier: String, node: SpriteNode) -> Bool {
        if node.position.x <= rockEndPos {
            node.removeFromParent()
            spriteNodes[identifier] = nil
            return true
        }
        
        return false
    }
    
    // Change ground position if it is off the screen.
    func updateGroundPosition() {
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
    func spawnNewRock() {
        var rockNodes: [String: SpriteNode] = [:]
        
        for (identifier, node) in spriteNodes {
            guard node.canAnimate else {
                return
            }
            if identifier.contains(SpriteIdentifiers.rock.rawValue) {
                rockNodes[identifier] = node
            }
        }
        
        // Create new rock node to be added to the game scene.
        let newRockNode = Rock()
        var randomXPosition = Int.random(in: minXPos...maxXPos)
        
        for (id, node) in spriteNodes {
            if id.contains(SpriteIdentifiers.rock.rawValue) {
                let nodeRange = (node.size.width * 4)
                if node.position.x - nodeRange...node.position.x + nodeRange ~= CGFloat(randomXPosition) {
                    randomXPosition += Int(nodeRange)
                }
            }
        }
        newRockNode.create(position: CGPoint(x: CGFloat(randomXPosition), y: rockYPos))
        
        // If filteredRockNodes is not empty, a new rock identifier needs to be created else we can reuse current rock identifier.
        if rockNodes.isEmpty {
            // No other rocks are present, use the first identifier again.
            spriteNodes["\(SpriteIdentifiers.rock.rawValue)1"] = newRockNode
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
                let newRockIdentifier = "\(SpriteIdentifiers.rock.rawValue)\(String(describing: newRockId))"
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
}

