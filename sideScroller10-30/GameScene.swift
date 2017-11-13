//
//  GameScene.swift
//  sideScroller10-25
//
//  Created by Emily on 10/25/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let ground = SKSpriteNode(imageNamed: "ground")
    let ground2  = SKSpriteNode(imageNamed: "ground")
    let ground3 = SKSpriteNode(imageNamed: "ground")
    
    
    var player = SKSpriteNode()
    var playerArray = [SKTexture]()
    
    var jump = SKSpriteNode()
    var playerJumpArray = [SKTexture]()
    var playerJumpArrayEnd = [SKTexture]()
    
    
    var playerRun: SKAction!
    var playerJump: SKAction!

    let playerStartY: CGFloat = 275
    
    let rock = SKSpriteNode(imageNamed: "rock")
    let minObjectX: UInt32 = 300
    let maxObjectX: UInt32 = 1740
    var timerFinished = false
    
    var timer: Timer?
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.4, alpha: 1)
        //self.background = SKSpriteNode(imageNamed: "sky")
        //background.position = CGPoint(x: 0, y: 0)
       // self.background.position = CGPoint(x: self.scene!.size.width / 2, y: self.scene!.size.height / 2)
        //self.addChild(background)
        
//        let initPosGround = CGPoint(x: -10, y: 75)
//        let intiPosGround2 = CGPoint(x: ground2.size.width - 10, y: 75)
//        let initPosGround3 = CGPoint(x: ground2.size.width + ground3.size.width - 10, y: 75)
        
        ground.position = CGPoint(x: 0, y: 75)
        self.addChild(ground)
        
        ground2.position = CGPoint(x: ground2.size.width - 1, y: 75)
        self.addChild(ground2)
        
        ground3.position = CGPoint(x: ground2.size.width + ground3.size.width - 1, y: 75)
        self.addChild(ground3)

       // let jumpUp = SKAction.moveBy(x: -5, y: 5, duration: 0.05)
        createPlayer()
        player.run(SKAction.repeatForever(SKAction.animate(with: playerArray, timePerFrame: 0.2)))
        
         //createObjects()
        
    }
    
    func createPlayer(){
        for var i in 0...3{
            let player1 = "dino1"
            let player2 = "dino2"
            let player3 = "dino3"
            let player4 = "dino4"
            
            
            playerArray.append(SKTexture(imageNamed: player1))
            playerArray.append(SKTexture(imageNamed: player2))
            playerArray.append(SKTexture(imageNamed: player3))
            playerArray.append(SKTexture(imageNamed: player4))
            
            i += 1
        }
        
        if(playerArray.count > 1){
            player = SKSpriteNode(imageNamed: "player1.png")
            player.position = CGPoint(x: (scene!.size.width / 3) - 75, y: 275)
            player.zPosition = 1
            player.size = CGSize( width: 256, height: 256)
            self.addChild(player)
        }
        
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump2"))
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump1"))
        
    }
    
    func randomNumInRange(min: Int, max: Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
        
    }
    func createObjects(){
        
        let number = randomNumInRange(min: 2, max: 10)
        timer = Timer.scheduledTimer(timeInterval: Double(number), target: self, selector: Selector(("rock")), userInfo: nil, repeats: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(number)) {
            self.rock.position = CGPoint(x: 1000, y: 75)
            self.addChild(self.rock)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0, delay: 1.0, options: UIViewAnimationOptions.curveEaseIn,
                       animations: {
                        let jumpUp = SKAction.moveBy(x: 0, y: 400, duration: 0.8)
                        let fallBack = SKAction.moveBy(x: 0, y: -400, duration: 0.8)
                        self.player.run(SKAction.sequence([jumpUp, fallBack]))
                        self.player.run(SKAction.animate(with: self.playerJumpArray, timePerFrame: 0.9))
        },completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.6) {
            self.isUserInteractionEnabled = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        let initPosGround3 = CGPoint(x: ground2.size.width + ground3.size.width - 10, y: 75)
        
        ground.position = CGPoint(x: ground.position.x - 20, y: ground.position.y)
        ground2.position = CGPoint(x: ground2.position.x - 20, y: ground2.position.y)
        ground3.position = CGPoint(x: ground3.position.x - 20, y: ground3.position.y)
        
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

