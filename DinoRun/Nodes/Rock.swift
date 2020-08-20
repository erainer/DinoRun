//
//  RockSpawn.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//
import SpriteKit

class Rock: SpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "rock")
        let size = CGSize( width: 180, height: 169)
        super.init(texture: texture, color: color, size: size)
        self.name = "rock"
        self.size = size
        self.zPosition = 3
        self.texture = texture
        self.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.rockCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    override func create(position: CGPoint) {
        self.position = position
    }
    
    override func animate(with animation: AnimationType? = nil, speed: CGFloat? = nil) {
        guard canAnimate,
            let rockSpeed = speed else {
            return
        }
         self.position = CGPoint(x: self.position.x - rockSpeed, y: self.position.y)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
