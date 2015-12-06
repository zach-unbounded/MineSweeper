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
    var audioEngine: AVAudioEngine = AVAudioEngine()
    var backgroundMusicFilePlayer: AVAudioPlayerNode = AVAudioPlayerNode()
    
    init() {
        // TODO : can we get some system audio engine that i can work with to intergrate into!
    }
    
    func startBackgroundMusic(startVolume : Float) {
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
                    backgroundMusicFilePlayer.volume = startVolume
                    backgroundMusicFilePlayer.play()
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
    
    
}
