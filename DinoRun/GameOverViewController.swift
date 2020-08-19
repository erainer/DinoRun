//
//  GameOverViewController.swift
//  sideScroller10-30
//
//  Created by Emily on 12/6/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameOverViewController: UIViewController {
    let scene = GameOver()
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameOver(size:CGSize(width: 1920, height: 900))
        let SKView = self.view as! SKView
        SKView.showsFPS = true
        SKView.showsPhysics = true
        SKView.showsNodeCount = true
        SKView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        SKView.presentScene(scene)
        
    }
    
}
