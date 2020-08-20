//
//  GameViewController.swift
//  sideScroller10-30
//
//  Created by Emily on 10/30/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//
// MARK: - GameViewController
//
class GameViewController: UIViewController {
    
    //
    // MARK: - Properties
    //
    let scene = GameScene()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size:CGSize(width: 1920, height: 900))
        let SKView = self.view as! SKView
        SKView.showsPhysics = false
        SKView.ignoresSiblingOrder = true
        scene.scaleMode = .aspectFill
        SKView.presentScene(scene)
        
    }
    
}
