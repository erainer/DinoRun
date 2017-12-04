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

class startMenu: UIViewController{
    var menuMusic = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do{
            try menuMusic = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "menu", ofType: "mp3")!) as URL)
        } catch{
            NSLog("Error: Menu Audio is not working correctly.")
        }
        menuMusic.play()
    }

    @IBAction func playButton(_ sender: Any) {
        menuMusic.stop()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.landscape.rawValue)
    }
}
