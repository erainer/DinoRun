//
//  Ground.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class Ground: SKSpriteNode {
    let ground = SKSpriteNode(imageNamed: "ground")
    let ground2  = SKSpriteNode(imageNamed: "ground")
    let ground3 = SKSpriteNode(imageNamed: "ground")
    
    convenience init() {
        self.init(imageNamed:"ground")
        createGround()
    }
    
    func createGround(){
        //Displays the ground
        ground.position = CGPoint(x: 0, y: 75)
        self.addChild(ground)
        ground2.position = CGPoint(x: ground2.size.width - 1, y: 75)
        self.addChild(ground2)
        ground3.position = CGPoint(x: ground2.size.width + ground3.size.width - 1, y: 75)
        self.addChild(ground3)
    }
    
    func moveGround(){
        let initPosGround3 = CGPoint(x: ground2.size.width + ground3.size.width - 10, y: 75)
        //Moves the grounds left
        ground.position = CGPoint(x: ground.position.x - 20, y: ground.position.y)
        ground2.position = CGPoint(x: ground2.position.x - 20, y: ground2.position.y)
        ground3.position = CGPoint(x: ground3.position.x - 20, y: ground3.position.y)
        
        //Resets the position of the ground once it is off the screen
        if(ground.position.x < -510){
            ground.position.x = initPosGround3.x + 510
        }
        
        if(ground2.position.x < -510){
            ground2.position.x = initPosGround3.x + 510
        }
        
        if(ground3.position.x < -510){
            ground3.position.x = initPosGround3.x + 510
        }
    }
}
