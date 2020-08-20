//
//  Life.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//
import SpriteKit

class Life: SpriteNode {
    
    //
    // MARK: - Life Lifecycle
    //
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "life-icon")
        let color = UIColor.clear
        let size = CGSize(width: 106, height: 96)
        super.init(texture: texture, color: color, size: size)
        self.name = "life"
        self.size = size
        self.zPosition = 2
        self.texture = texture
    }
    
    override func create(position: CGPoint) {
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
