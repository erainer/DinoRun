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
    
    override func animate(with animation: AnimationType? = nil, speed: CGFloat? = nil) {
        guard canAnimate,
            let groundSpeed = speed else {
            return
        }
        self.position = CGPoint(x: self.position.x - groundSpeed, y: self.position.y)
    }
}
