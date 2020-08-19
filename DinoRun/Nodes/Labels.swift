//
//  Labels.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import SpriteKit

class Labels: SKLabelNode {
    
    override init() {
        super.init()
        self.horizontalAlignmentMode = .right
        self.fontSize = 50
        self.color = UIColor.black
        self.zPosition = 9
    }
    
    func create(position: CGPoint, color: UIColor? = .black, text: String) {
        self.position = position
        self.fontColor = color
        self.text = "Score: \(text)"
    }
    
    func updateText(text: String) {
        self.text = "Score: \(text)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
