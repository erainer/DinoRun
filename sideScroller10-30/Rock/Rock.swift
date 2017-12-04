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

class Rock: SKSpriteNode {
    let rock = SKSpriteNode(imageNamed: "rock")
    var spawnTimer: Timer?
//    let rock2 = SKSpriteNode(imageNamed: "rock")
//    let rock3 = SKSpriteNode(imageNamed: "rock")
   // var randX: Int = 0
    
    convenience init() {
        self.init(imageNamed:"rock")
        self.addChild(rock)
        
        //startGenerating(seconds: 1)
        //loadPhyisicsBody()
        //createObjects()
    }
    
//    func randomNumInRange(min: Int, max: Int) -> Int{
//        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
//    }
//
    func createObjects(){
        //randX = randomNumInRange(min: Int(minObjectX), max: Int(maxObjectX))
        //initalize position
        //self.rock.position = CGPoint(x: randX, y: rockYPos)
//        self.rock2.position = CGPoint(x: randX, y: rockYPos)
//        self.rock3.position = CGPoint(x: randX, y: rockYPos)

        self.rock.name = "rock1"
//        self.rock2.name = "rock2"
//        self.rock3.name = "rock3"

        //add to screen
//        self.addChild(rock1)
//        self.addChild(rock2)
//        self.addChild(rock3)
    }
//
//    func loadPhyisicsBody(){
//        physicsBody = SKPhysicsBody(circleOfRadius: 60)
//        physicsBody?.categoryBitMask = rockCategory
//        physicsBody?.affectedByGravity = false
//    }
//
    func moveRock(){
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

