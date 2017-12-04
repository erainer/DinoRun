//
//  RockSpawn.swift
//  sideScroller10-30
//
//  Created by Emily on 11/27/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit
import SpriteKit

class RockSpawn: SKSpriteNode {
    
    var spawnTimer: Timer?
    let ground = Ground()
    @objc let rock = Rock()
    
    func startGenerating(seconds: TimeInterval){
        spawnTimer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(getter: RockSpawn.rock), userInfo: nil, repeats: true)
    }
    
    func generateRock(){
        rock.position.x = 1920 + rock.size.width
        rock.position.y = (CGFloat(rockYPos) - 200)
        addChild(rock)
        rock.moveRock()
    }
}
