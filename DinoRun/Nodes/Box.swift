//
//  Box.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

class Box: SpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "box")
        let size = CGSize( width: 1105, height: 667)
        super.init(texture: texture, color: color, size: size)
        self.name = "box"
        self.size = size
        self.zPosition = 5
        self.texture = texture
        self.alpha = 0.8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func create(position: CGPoint) {
        self.position = position
    }
}
