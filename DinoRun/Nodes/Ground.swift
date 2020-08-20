//
//  Ground.swift
//  sideScroller10-30
//
//  Created by Emily Rainer on 8/18/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import SpriteKit

//
// MARK: - Ground SpriteNode
//
class Ground: SpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = size
        self.texture = texture
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForScene(position: CGPoint, name: String, zPosition: CGFloat) {
        self.position = position
        self.name = name
        self.zPosition = zPosition
    }
    
    override func animate(with animation: AnimationType? = nil, speed: CGFloat? = nil) {
        guard canAnimate,
            let groundSpeed = speed else {
            return
        }
        self.position = CGPoint(x: self.position.x - groundSpeed, y: self.position.y)
    }
}
