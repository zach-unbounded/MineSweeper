//
//  MSSoundSystem.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import Foundation
import AVFoundation

class MSSoundSystem {
    static let sharedInstance = MSSoundSystem()
    let backgroundMusicFileURL:NSURL = NSBundle.mainBundle().URLForResource("backgroundMusic", withExtension: "mp3")!
    var soundSession:AVAudioSession = AVAudioSession.sharedInstance()
    var audioEngine: AVAudioEngine = AVAudioEngine()
    var backgroundMusicFilePlayer: AVAudioPlayerNode
    
    init() {
        // init the sound session
        do{
            try soundSession.setCategory(AVAudioSessionCategoryAmbient)
        }
        catch {
            NSLog("Problem setting up ambient categry")
        }
        backgroundMusicFilePlayer = AVAudioPlayerNode()
        self.setupBackgroundMusic()
    }
    
    func setupBackgroundMusic() {
        var audioFile : AVAudioFile
        
        do {
            print("Background Music file location: \(backgroundMusicFileURL.absoluteString)")
            audioFile = try AVAudioFile(forReading: backgroundMusicFileURL)
            let audioFormat = audioFile.processingFormat
            let audioFrameCount = UInt32(audioFile.length)
            let audioFileBuffer = AVAudioPCMBuffer(PCMFormat: audioFormat, frameCapacity: audioFrameCount)
            
            do {
                try audioFile.readIntoBuffer(audioFileBuffer, frameCount:audioFrameCount)
                
                let mainMixer = audioEngine.mainMixerNode
                audioEngine.attachNode(backgroundMusicFilePlayer)
                audioEngine.connect(backgroundMusicFilePlayer, to:mainMixer, format:audioFileBuffer.format)
                
                do {
                    try audioEngine.start()
                    
                    // setting volume to half. and pause the music until we are ready to play!
                    backgroundMusicFilePlayer.volume = 0.5
                    backgroundMusicFilePlayer.pause()
                    backgroundMusicFilePlayer.scheduleBuffer(audioFileBuffer, atTime: nil, options:.Loops, completionHandler: nil)
                } catch {
                    print("Failed to start engine!");
                }
            } catch {
                print("Failed to read into buffer!");
            }
        }
        catch {
            print("Background music failed to load!");
        }
    }
    
    func setVolumeForBackgroundMusic(newVolume : Float) {
        backgroundMusicFilePlayer.volume = newVolume
    }
    
    func stopBackgroundMusic() {
        if backgroundMusicFilePlayer.playing {
            backgroundMusicFilePlayer.stop()
        }
    }
    
    func switchBackgroundPause() {
        if backgroundMusicFilePlayer.playing {
            backgroundMusicFilePlayer.pause()
        }
        else {
            backgroundMusicFilePlayer.play()
        }
    }
    
    func playBackgroundMusic() {
        if !backgroundMusicFilePlayer.playing {
            backgroundMusicFilePlayer.play()
        }
    }
    
    func shutdown() {
        backgroundMusicFilePlayer.stop()
    }
    
}
