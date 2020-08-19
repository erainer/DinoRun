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
// MARK: - GameScene
//
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //
    // MARK: - Nodes
    //
    var SpriteNodes: [String: SpriteNode] = [:]
    var player = Player()
    var ground1 = Ground()
    var ground2 = Ground()
    var ground3 = Ground()
    var ground4 = Ground()
    var rock1 = Rock()
    var rock2 = Rock()
    var background = Background()
    var scoreLabel = Labels()
    
    //
    // MARK: - Variables
    //
    var score: Int = 0
    let groundSpeed: CGFloat = -5.0
    let groundWidth: CGFloat = 1023.0
    let minObjectX: UInt32 = 1900
    let maxObjectX: UInt32 = 4000
    var spawnTimer: TimeInterval = 0
    var timerFinished: Bool = false
    var rockHitPlayer: Bool = false
    
    // Positions
    let rockYPos: CGFloat = 200.0
    let groundYPos: CGFloat = 75.0
    let endOfGroundPos: CGFloat = -510.0
    let playerYPos: CGFloat = 275.0
    
    //
    // MARK: - GameScene Lifecycle
    //
    override func didMove(to view: SKView) {

        // Set physics of game scene.
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        // Create Nodes.
        player.create(position: CGPoint(x: 500, y: playerYPos))
        rock1.create(position: CGPoint(x: 3000, y: rockYPos))
        ground1.create(position: CGPoint(x: 0, y: groundYPos))
        ground2.create(position: CGPoint(x: ground1.position.x + groundWidth, y: groundYPos))
        ground3.create(position: CGPoint(x: ground2.position.x + groundWidth, y: groundYPos))
        ground4.create(position: CGPoint(x: ground3.position.x + groundWidth, y: groundYPos))
        background.create(position: CGPoint(x: 960, y: 600))
        scoreLabel.create(position: CGPoint(x: 1600, y: 800), text: String(describing: score))
        
        // Flip the even grounds so they line up.
        ground2.xScale = ground2.xScale * -1
        ground4.xScale = ground4.xScale * -1
        
        // Add sprites to the SpriteNodes dictionary.
        SpriteNodes["player"] = player
        SpriteNodes["rock1"] = rock1
        SpriteNodes["ground1"] = ground1
        SpriteNodes["ground2"] = ground2
        SpriteNodes["ground3"] = ground3
        SpriteNodes["ground4"] = ground4
        SpriteNodes["background"] = background
        
        // Add nodes to scene.
        for (_, node) in SpriteNodes {
            addChild(node)
        }
        
        addChild(scoreLabel)
    }
    
    // Collision detection
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
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.rockHitPlayer = false
            }
        }
        
        // Enables user interaction.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isUserInteractionEnabled = true
        }
    }
    
    // Detect user screen touches.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Disables user interaction.
        self.isUserInteractionEnabled = false
        
        // Play jump animation for player.
        player.animate(with: .jump)
        
        // Enables user interaction.
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isUserInteractionEnabled = true
        }
    }
    
    // Used to update all nodes.
    override func update(_ currentTime: TimeInterval) {
    
        for (identifier, node) in SpriteNodes {
            if identifier.contains("rock") {
                node.animate()
    
                if !rockHitPlayer &&
                    node.position.x - 5...node.position.x + 5 ~= player.position.x {
                    score += 5
                }
            }
            
            if identifier.contains("ground") {
                node.animate()
            }
        }
        
        // Check all ground positions to rotate them.
        checkGroundPositions()
        
        // Update score.
        scoreLabel.updateText(text: String(describing: score))
    }
    
    // Change ground position if it is off the screen.
    func checkGroundPositions() {
        if ground1.position.x < endOfGroundPos {
            ground1.position.x = ground4.position.x + groundWidth
        }
        
        if ground2.position.x < endOfGroundPos {
            ground2.position.x = ground1.position.x + groundWidth
        }
        
        if ground3.position.x < endOfGroundPos {
            ground3.position.x = ground2.position.x + groundWidth
        }
        
        if ground4.position.x < endOfGroundPos {
            ground4.position.x = ground3.position.x + groundWidth
        }
    }
    
//    func randomNumInRange(min: Int, max: Int) -> Int{
//        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
//    }
//
//    func spawnRock() {
//        let wait = SKAction.wait(forDuration: 3, withRange: 0.5)
//        let spawn = SKAction.run({
//            self.rock1.create(position: CGPoint(x: 500, y: self.rockYPos))
//        })
//        let spawning = SKAction.sequence([wait,spawn])
//        self.run(SKAction.repeatForever(spawning), withKey: "spawning")
//    }
}

