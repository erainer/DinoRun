//
//  SettingsMenu.swift
//  sideScroller10-30
//
//  Created by Emily Rainer on 8/18/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

//
// MARK: - SettingsMenu
//
class SettingsMenu: UIViewController {
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var volumeLabel: UILabel!

    //
    // MARK: - Properties
    //
    var volume: Float = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        volumeLabel.text = String(Int(volume))
    }
    
    @IBAction func volumeUpButton(_ sender: Any) {
        if volume != 5 {
            volume += 1
            AudioController.shared.updateVolume(volume: volume)
        }
        
        volumeLabel.text = String(Int(volume))
    }
    
    @IBAction func volumeDownButton(_ sender: UIButton) {
        if volume != 0 {
            volume -= 1
            AudioController.shared.updateVolume(volume: volume)
        }
        
        volumeLabel.text = String(Int(volume))
    }
}
