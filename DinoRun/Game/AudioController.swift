//
//  AudioController.swift
//  sideScroller10-30
//
//  Created by Emily Rainer on 8/18/20.
//  Copyright © 2020 Emily Rainer. All rights reserved.
//

import AVFoundation

class AudioController {
    
    public static let shared = AudioController()
    public var menuMusic = AVAudioPlayer()
    public var gameMusic = AVAudioPlayer()
    public var gameOverSound = AVAudioPlayer()
    var firstRun: Bool = true
    
    func setupMenuAudio() {

        if firstRun {
            do {
                guard let menuMusicPath = Bundle.main.path(forResource: "menu", ofType: "mp3") else {
                    return
                }
                let menuMusicNSURL = NSURL(fileURLWithPath: menuMusicPath)
                try menuMusic = AVAudioPlayer(contentsOf: menuMusicNSURL as URL)
                menuMusic.volume = 1
            } catch {
                NSLog("Error: Menu Audio is not working correctly.")
            }
            
            playAudio(sound: menuMusic)
            firstRun = false
        }
    }
    
    func setupGameAudio() {
        do {
            guard let gameMusicPath = Bundle.main.path(forResource: "gameMusic", ofType: "mp3") else {
                return
            }
            let gameMusicNSURL = NSURL(fileURLWithPath: gameMusicPath)
            try gameMusic = AVAudioPlayer(contentsOf: gameMusicNSURL as URL)
            gameMusic.volume = 1
        } catch {
            NSLog("Error: Menu Audio is not working correctly.")
        }
    }
    
    func setupGameOverAudio() {
        do {
            guard let gameOverPath = Bundle.main.path(forResource: "gameOver", ofType: "mp3") else {
                return
            }
            let gameOverNSURL = NSURL(fileURLWithPath: gameOverPath)
            try gameOverSound = AVAudioPlayer(contentsOf: gameOverNSURL as URL)
            gameOverSound.volume = 1
        } catch {
            NSLog("Error: Menu Audio is not working correctly.")
        }
    }
    
    func playAudio(sound: AVAudioPlayer) {
        sound.currentTime = 0
        sound.play()
    }
    
    func stopAudio(sound: AVAudioPlayer) {
        sound.stop()
    }
    
    func updateVolume(volume: Float) {
        menuMusic.volume = volume
        gameMusic.volume = volume
        gameOverSound.volume = volume
    }
}
