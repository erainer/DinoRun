//
//  Box.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

//
// MARK: - Box SpriteNode
//
class Box: SpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = size
        self.texture = texture
        self.alpha = 0.8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForScene(position: CGPoint, name: String, zPosition: CGFloat) {
        self.position = position
        self.name = name
        self.zPosition = zPosition
    }
}
