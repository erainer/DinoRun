//
//  Player.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

class Player: SKSpriteNode, Constants{

    var player = SKSpriteNode()
    var playerArray = [SKTexture]()
    let player1 = "dino1"
    let player2 = "dino2"
    let player3 = "dino3"
    let player4 = "dino4"
    
    //Player Array
    var playerJumpArray = [SKTexture]()
    var playerJumpArrayEnd = [SKTexture]()
    
    //Player Actions
    var playerRun: SKAction!
    var playerJump: SKAction!
    
    //Player Start Position Y
    let playerStartY: CGFloat = 275
    
    convenience init() {
        self.init(texture: p, color: UIColor.blue, size: player.size)
        createPlayer()
        player.run(SKAction.repeatForever(SKAction.animate(with: playerArray, timePerFrame: 0.2)))
    }
    
    func createPlayer(){
        //Adds the images to the player array
        playerArray.append(SKTexture(imageNamed: player1))
        playerArray.append(SKTexture(imageNamed: player2))
        playerArray.append(SKTexture(imageNamed: player3))
        playerArray.append(SKTexture(imageNamed: player4))
        
        //Player Properties
        player.name = "player"
        player.zPosition = 1
        player.size = CGSize( width: 256, height: 256)
        
        //Adds the images to the jump array
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump2"))
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump1"))
    }


    func animatePlayerJump(){
        //plays jump animation
        let jumpUp = SKAction.moveBy(x: 0, y: 300, duration: 0.6)
        let fallBack = SKAction.moveBy(x: 0, y: -300, duration: 0.6)
        self.player.run(SKAction.sequence([jumpUp, fallBack]))
        self.player.run(SKAction.animate(with: playerJumpArray, timePerFrame: 0.6))
    }
}
