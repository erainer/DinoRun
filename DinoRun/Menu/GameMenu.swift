//
//  ViewController.swift
//  sideScroller10-30
//
//  Created by Emily on 11/8/17.
//  Copyright © 2017 Emily Rainer. All rights reserved.
//
import SpriteKit

//
// MARK: - GameMenu
//
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AudioController.shared.setupMenuAudio()
    }
    
    @IBAction func playButton(_ sender: Any) {
        AudioController.shared.stopAudio(sound: AudioController.shared.menuMusic)
        AudioController.shared.setupGameAudio()
        AudioController.shared.firstRun = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
