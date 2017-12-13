//
//  GameScene.swift
//  sideScroller10-25
//
//  Created by Emily on 10/25/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate{
    //Score
    var scoreLabel = SKLabelNode()
    var score: Int = 0
    
    let rock = SKSpriteNode(imageNamed: "rock")
    
    //Player
    var player = SKSpriteNode()
    var playerArray = [SKTexture]()
    let player1 = "dino1"
    let player2 = "dino2"
    let player3 = "dino3"
    let player4 = "dino4"
    
    //Player Array
    var playerJumpArray = [SKTexture]()
    var playerJumpArrayEnd = [SKTexture]()
    
    //Player Hit
    var playerHit = SKTexture(imageNamed: "dinoJump1")
    
    //Player Actions
    var playerRun: SKAction!
    var playerJump: SKAction!
    var Over = false
    var ground = Ground()
    //var rock = Rock()
    //var menu = startMenu()
    //timers
    var timerFinished = false
    var spawnTimer: TimeInterval = 0
    
    //Audio
    var gameMusic = AVAudioPlayer()
    //var rockSpawner = RockSpawn()
    
    override func didMove(to view: SKView) {
        Audio()
        loadGame()
        loadPhyisicsBody()
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self    
    }

    func loadGame(){
        //Background
        self.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.4, alpha: 1)
        
        //Add to scene
        self.addChild(ground);
        spawnRock()
        self.addChild(rock)
        //generateRock()
        //renderer(_renderer: self as! SCNSceneRendererDelegate, updateTime: spawnTimer)
        //Displays the score
        scoreLabel.fontSize = 60
        scoreLabel.text = String(score)
        scoreLabel.position = CGPoint(x: 1600, y: 800)
        self.addChild(scoreLabel)

        //Creates the player and animates
        createPlayer()
        player.run(SKAction.repeatForever(SKAction.animate(with: playerArray, timePerFrame: 0.2)))
    }
    
    func loadPhyisicsBody(){
        player.physicsBody = SKPhysicsBody(circleOfRadius: 80)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.categoryBitMask = PhysicsCategory.playerCategory
        player.physicsBody?.contactTestBitMask = PhysicsCategory.rockCategory
        player.physicsBody?.collisionBitMask = PhysicsCategory.none
    }
    
    func Audio(){
//        do{
//            try gameMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "gameMusic", ofType: "mp3")!) as URL)
//        } catch{
//            NSLog("Error: Game music is not working correctly.")
//        }
//        //menu.menuMusic.stop()
//        gameMusic.play()
    }
    
    func createPlayer(){
        //Adds the images to the player array
        playerArray.append(SKTexture(imageNamed: player1))
        playerArray.append(SKTexture(imageNamed: player2))
        playerArray.append(SKTexture(imageNamed: player3))
        playerArray.append(SKTexture(imageNamed: player4))
        
        //Player Properties
        player.name = "player"
        player.position = CGPoint(x: (scene!.size.width / 3) - 75, y: 275)
        player.zPosition = 1
        player.size = CGSize( width: 256, height: 256)
        self.addChild(player)
    
        //Adds the images to the jump array
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump2"))
        playerJumpArray.append(SKTexture(imageNamed: "dinoJump1"))
    }
    
    
    func randomNumInRange(min: Int, max: Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func spawnRock(){
        let wait = SKAction.wait(forDuration: 3, withRange: 0.5)
        let spawn = SKAction.run({
            self.generateRock()
        })
        let spawning = SKAction.sequence([wait,spawn])
        self.run(SKAction.repeatForever(spawning), withKey: "spawning")
    }
    
    func moveRock(){
        let moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 10)
        //if(gameOver == false){
            rock.run(SKAction.repeatForever(moveLeft))
        //} else{
            //rock.run(SKAction.pause())
        //}
    }
    func generateRock(){
        rock.position.x = (self.scene?.size.width)! + rock.size.width
        rock.position.y = (CGFloat(rockYPos))
        
        //rock physics
        rock.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        rock.physicsBody?.isDynamic = true
        rock.physicsBody?.categoryBitMask = PhysicsCategory.rockCategory
        rock.physicsBody?.contactTestBitMask = PhysicsCategory.playerCategory
        rock.physicsBody?.collisionBitMask = PhysicsCategory.none
        rock.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    func didBegin(_ contact: SKPhysicsContact){
        let firstBody: SKPhysicsBody
        let secondBody: SKPhysicsBody
        
        //Disables user interaction
        self.isUserInteractionEnabled = false
        
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if((firstBody.categoryBitMask & PhysicsCategory.playerCategory != 0) && (secondBody.categoryBitMask & PhysicsCategory.rockCategory != 0)){
            if let _ = firstBody.node as? SKSpriteNode, let _ = secondBody.node as? SKSpriteNode{
                self.player.run(SKAction.animate(with: [self.playerHit], timePerFrame: 1))
                //gameOver = true
                print("Hit")
                
               
                //self.navigationController?.pushViewController(vc!, animated: true)
        
                
                //var nextView = performSegue.destination as! GameOver
                //nextView.performSegue(withIdentifier: "gameOverVC", sender: Any?.self)
//                let storyBoard : UIViewController = UIViewController(coder: "GameOverVC")
//                SKScene.performSegueWithIdentifier("GameOverVC", sender: nil)
//
                
                //let nextViewController = self.scene.instantiateViewController(withIdentifier: "gameOverVC") as! GameOver
            //self.navigationController.pushViewController(nextViewController, animated:true, completion:nil)
            }
        }
        //Enables user interaction
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isUserInteractionEnabled = true
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Disables user interaction
        self.isUserInteractionEnabled = false
    
        //plays jump animation
        let jumpUp = SKAction.moveBy(x: 0, y: 300, duration: 0.6)
        let fallBack = SKAction.moveBy(x: 0, y: -300, duration: 0.6)
        self.player.run(SKAction.sequence([jumpUp, fallBack]))
        self.player.run(SKAction.animate(with: self.playerJumpArray, timePerFrame: 0.6))

        //Enables user interaction
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isUserInteractionEnabled = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        ground.moveGround()
        moveRock()
          //rock.moveRock()
//        if(player.position.x > rock1.position.x){
//                self.score += 5
//                self.scoreLabel.text = String(self.score)
//        }else if(player.position.x > rock2.position.x){
//            score += 5
//            scoreLabel.text = String(score)
//        }else if(player.position.x > rock3.position.x){
//            score += 5
//            scoreLabel.text = String(score)
//        }
        
    }
    
   
}

