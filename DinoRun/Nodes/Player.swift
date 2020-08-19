//
//  Player.swift
//  sideScroller10-30
//
//  Created by Emily Rainer on 8/18/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

class Player: SpriteNode {

    var playerRunArray = [SKTexture]()
    var playerJumpArray = [SKTexture]()
    var playerJumpArrayEnd = [SKTexture]()
    let jumpUp = SKAction.moveBy(x: 0, y: 300, duration: 0.6)
    let fallBack = SKAction.moveBy(x: 0, y: -300, duration: 0.6)
    var playerHit = SKTexture(imageNamed: "dinoJump1")
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "rock")
        let size = CGSize( width: 256, height: 256)
        super.init(texture: texture, color: color, size: size)
        self.name = "player"
        self.size = size
        self.zPosition = 4
        self.texture = texture
        self.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.rockCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func create(position: CGPoint) {
        playerRunArray.append(SKTexture(imageNamed: "dino1"))
        playerRunArray.append(SKTexture(imageNamed: "dino2"))
        playerRunArray.append(SKTexture(imageNamed: "dino3"))
        playerRunArray.append(SKTexture(imageNamed: "dino4"))
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump2"))
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump1"))
        self.position = position
        self.run(SKAction.repeatForever(SKAction.animate(with: playerRunArray, timePerFrame: 0.2)))
    }
    
    override func animate(with animation: AnimationType? = nil) {
        switch animation {
        case .run:
            self.run(SKAction.repeatForever(SKAction.animate(with: playerRunArray, timePerFrame: 0.2)))
        case .jump:
            self.run(SKAction.sequence([jumpUp, fallBack]))
            self.run(SKAction.animate(with: self.playerJumpArray, timePerFrame: 0.6))
        case .hit:
            self.run(SKAction.animate(with: [self.playerHit], timePerFrame: 1))
        case .none:
            return
        }
        
    }
}
