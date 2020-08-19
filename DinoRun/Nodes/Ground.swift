//
//  Ground.swift
//  sideScroller10-30
//
//  Created by Emily Rainer on 8/18/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import SpriteKit

class Ground: SpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "ground")
        let size = CGSize( width: 1024, height: 210)
        super.init(texture: texture, color: color, size: size)
        self.name = "ground"
        self.size = size
        self.zPosition = 2
        self.texture = texture
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func create(position: CGPoint) {
        self.position = position
    }
    
    override func animate(with animation: AnimationType? = nil) {
        self.position = CGPoint(x: self.position.x - 5, y: self.position.y)
    }
    
//    
//    func moveGround() {
//        let initPosGround3 = CGPoint(x: ground2.size.width + ground3.size.width - 10, y: 75)
//        // Moves the grounds to the left.
//        ground.position = CGPoint(x: ground.position.x - 5, y: ground.position.y)
//        ground2.position = CGPoint(x: ground2.position.x - 5, y: ground2.position.y)
//        ground3.position = CGPoint(x: ground3.position.x - 5, y: ground3.position.y)
//        
//        // Resets the position of the ground once it is off the screen.
//        if ground.position.x < -510 {
//            ground.position.x = initPosGround3.x + 510
//        }
//        
//        if ground2.position.x < -510 {
//            ground2.position.x = initPosGround3.x + 510
//        }
//        
//        if ground3.position.x < -510 {
//            ground3.position.x = initPosGround3.x + 510
//        }
//    }
}
