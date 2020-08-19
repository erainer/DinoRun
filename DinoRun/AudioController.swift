//
//  AudioController.swift
//  sideScroller10-30
//
//  Created by Emily Rainer on 8/18/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import AVFoundation
import AudioToolbox

protocol AudioController: AVAudioPlayer {
    func setupMenuAudio()
    func stopAudio()
}

extension AudioController {
    
    func setupMenuAudio() {
        
        var menuMusic = AVAudioPlayer()
        
        do {
            guard let menuMusicPath = Bundle.main.path(forResource: "menu", ofType: "mp3") else {
                return
            }
            let menuMusicNSURL = NSURL(fileURLWithPath: menuMusicPath)
            try menuMusic = AVAudioPlayer(contentsOf: menuMusicNSURL as URL)
        } catch {
            NSLog("Error: Menu Audio is not working correctly.")
        }
    }
    
    func playAudio() {
        self.play()
    }
    
    func stopAudio() {
        self.stop()
    }
}
