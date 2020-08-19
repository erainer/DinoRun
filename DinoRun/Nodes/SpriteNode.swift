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

class SpriteNode: SKSpriteNode {
    var spawnTimer: Timer?
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.size = size
        self.texture = texture
    }
    
    func create(position: CGPoint) {
    }
    
    func animate(with animation: AnimationType? = nil) {
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomNumInRange(min: Int, max: Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

    func moveRock() {
        let moveLeft = SKAction.moveBy(x: -300, y: 0, duration: 1)
        run(SKAction.repeatForever(moveLeft))
//        self.rock1.position = CGPoint(x: self.rock1.position.x - 20, y: self.rock1.position.y)
//        self.rock2.position = CGPoint(x: self.rock1.position.x - 20, y: self.rock1.position.y)
//        self.rock3.position = CGPoint(x: self.rock1.position.x - 20, y: self.rock1.position.y)
//
//        if(rock1.position.x < -180){
//            randX = randomNumInRange(min: Int(minObjectX), max: Int(maxObjectX))
//            self.rock1.position = CGPoint(x: randX, y: rockYPos)
//        }
//
//        if(rock2.position.x < -180){
//            randX = randomNumInRange(min: Int(minObjectX), max: Int(maxObjectX))
//            self.rock2.position = CGPoint(x: randX, y: rockYPos)
//        }
//
//        if(rock3.position.x < -180){
//            randX = randomNumInRange(min: Int(minObjectX), max: Int(maxObjectX))
//            self.rock3.position = CGPoint(x: randX, y: rockYPos)
//        }
    }
    
//    func startGenerating(seconds: TimeInterval){
//        spawnTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: Selector("generateRock"), userInfo: nil, repeats: false)
//    }
    
    


}

