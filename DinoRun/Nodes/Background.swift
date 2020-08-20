//
//  Background.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

//
// MARK: - Background SpriteNode
//
class Background: SpriteNode {

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
        self.zPosition = zPosition
        self.name = name
    }
}
