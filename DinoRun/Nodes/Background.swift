//
//  Background.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

class Background: SpriteNode {

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "sky")
        let size = CGSize( width: 1920, height: 1282)
        super.init(texture: texture, color: color, size: size)
        self.name = "background"
        self.size = size
        self.zPosition = 1
        self.texture = texture
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func create(position: CGPoint) {
        self.position = position
    }
}
