//
//  Player.swift
//  sideScroller10-30
//
//  Created by Emily Rainer on 8/18/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

//
// MARK: - Player SpriteNode
//
class Player: SpriteNode {

    //
    // MARK: - Properties
    //
    var playerRunArray = [SKTexture]()
    var playerJumpArray = [SKTexture]()
    var playerJumpArrayEnd = [SKTexture]()
    var playerHit = SKTexture(imageNamed: "dinoJump1")
    let jumpUp = SKAction.moveBy(x: 0, y: 300, duration: 0.4)
    let fallBack = SKAction.moveBy(x: 0, y: -300, duration: 0.4)
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = size
        self.texture = texture
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForScene(position: CGPoint, name: String, zPosition: CGFloat) {
        playerRunArray.append(SKTexture(imageNamed: "dino1"))
        playerRunArray.append(SKTexture(imageNamed: "dino2"))
        playerRunArray.append(SKTexture(imageNamed: "dino3"))
        playerRunArray.append(SKTexture(imageNamed: "dino4"))
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump2"))
        self.position = position
        self.zPosition = zPosition
        self.name = name
        self.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.rockCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        
        self.run(SKAction.repeatForever(SKAction.animate(with: playerRunArray, timePerFrame: 0.2)))
    }
    
    override func animate(with animation: AnimationType? = nil, speed: CGFloat? = nil) {
        guard canAnimate else {
            return
        }
        
        switch animation {
        case .run:
            self.run(SKAction.repeatForever(SKAction.animate(with: playerRunArray, timePerFrame: 0.2)))
        case .jump:
            self.run(SKAction.sequence([jumpUp, fallBack]))
            self.run(SKAction.animate(with: self.playerJumpArray, timePerFrame: 0.4))
        case .hit:
            self.run(SKAction.animate(with: [self.playerHit], timePerFrame: 1))
        case .none:
            return
        }
        
    }
}
