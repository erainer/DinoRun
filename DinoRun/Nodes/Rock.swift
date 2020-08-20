//
//  RockSpawn.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//
import SpriteKit

//
// MARK: - Rock SpriteNode
//
class Rock: SpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = size
        self.texture = texture
    }
    
    override func prepareForScene(position: CGPoint, name: String, zPosition: CGFloat) {
        self.position = position
        self.name = name
        self.zPosition = zPosition
        self.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = PhysicsCategory.rockCategory
        self.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.usesPreciseCollisionDetection = true
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
