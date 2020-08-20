//
//  Labels.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import SpriteKit

class Label: SKLabelNode {
    
    override init() {
        super.init()
        self.horizontalAlignmentMode = .right
        self.fontSize = 50
        self.fontName = "Arial"
        self.color = UIColor.black
        self.zPosition = 7
    }
    
    func create(position: CGPoint, color: UIColor? = .black, text: String) {
        self.position = position
        self.fontColor = color
        self.text = "\(text)"
    }
    
    func updateText(text: String) {
        self.text = "\(text)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
