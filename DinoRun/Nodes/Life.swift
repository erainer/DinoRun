//
//  Life.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

//
// MARK: - Life SpriteNode
//
class Life: SpriteNode {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = size
        self.texture = texture
    }
    
    override func prepareForScene(position: CGPoint, name: String, zPosition: CGFloat) {
        self.position = position
        self.name = name
        self.zPosition = zPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
