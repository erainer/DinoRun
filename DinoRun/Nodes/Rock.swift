//
//  RockSpawn.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//
import SpriteKit

class Rock: SpriteNode {
    
    let moveLeft = SKAction.moveBy(x: -30, y: 0, duration: 10)
    
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
    
    override func animate(with animation: AnimationType? = nil) {
         self.run(moveLeft)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    var spawnTimer: Timer?
//    let ground = Ground()
//    @objc let rock = Rock()
    
//    func startGenerating(seconds: TimeInterval){
//        spawnTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(getter: RockSpawn.rock), userInfo: nil, repeats: true)
//    }
//
//    func generateRock(){
//        rock.position.x = 1920 + rock.size.width
//        rock.position.y = (CGFloat(rockYPos) - 200)
//        addChild(rock)
//        rock.moveRock()
//    }
}
