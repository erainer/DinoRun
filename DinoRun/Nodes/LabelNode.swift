//
//  Labels.swift
//  DinoRun
//
//  Created by Emily Rainer on 8/19/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import SpriteKit

//
// MARK: - LabelNode
//
class LabelNode: SKLabelNode {
    
    override init() {
        super.init()
        self.horizontalAlignmentMode = .right
        self.fontName = "Arial"
    }
    
    func prepareForScene(position: CGPoint, color: UIColor, fontSize: CGFloat, name: String, zPosition: CGFloat, text: String) {
        self.position = position
        self.fontColor = color
        self.fontSize = fontSize
        self.zPosition = zPosition
        self.name = name
        self.text = "\(text)"
    }
    
    func updateText(text: String) {
        self.text = "\(text)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
