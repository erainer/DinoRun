//
//  Rock.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

enum AnimationType {
    case run
    case jump
    case hit
}

//
// MARK: - SpriteNode
//
class SpriteNode: SKSpriteNode {

    var canAnimate: Bool = true
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = size
        self.texture = texture
    }
    
    func prepareForScene(position: CGPoint, name: String, zPosition: CGFloat) {
    }
    
    func animate(with animation: AnimationType? = nil, speed: CGFloat? = nil) {
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

