//
//  ViewController.swift
//  sideScroller10-30
//
//  Created by Emily on 11/8/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox
import SpriteKit
import GameplayKit

class GameMenu: UIViewController {
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var volumeLabel: UILabel!
    
    //
    // MARK: - Varibles
    //
    var volume = 0
    var menuMusic = AVAudioPlayer()
    var gameMusic = AVAudioPlayer()
    let gameScene = GameScene()
    var playMusic = true
    var num = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func plusBtn(_ sender: Any) {
        if volume != 5 {
            volume += 1
            menuMusic.volume += 1
        }
        volumeLabel.text = String(volume)
    }
    
    @IBAction func minusBtn(_ sender: Any) {
        if volume != 0 {
            volume -= 1
            menuMusic.volume -= 1
        }
        volumeLabel.text = String(volume)
       
    }
    
    @IBAction func playButton(_ sender: Any) {
        //menuMusic.stop()
        do{
            try gameMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "gameMusic", ofType: "mp3")!) as URL)
        } catch{
            NSLog("Error: Game music is not working correctly.")
        }
        
        gameMusic.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.landscape.rawValue)
    }
    
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//            if(gameScene.Over == true){
//                var nextView = segue.destination as! GameOver
//                nextView.performSegue(withIdentifier: "gameOverVC", sender: Any?.self)
//            }
//        }
    
}
