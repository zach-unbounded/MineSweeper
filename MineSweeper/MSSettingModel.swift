//
//  MSSettingModel.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import Foundation

struct MSSettingModelConstants {
    static let musicVolume = "MusicVloume"
    static let effectsVolume = "SoundEffectsVolume"
    static let gridSize = "GridSize"
    static let mineCount = "MineCount"
}

class MSSettingModel {
    static let sharedInstance = MSSettingModel()
    
    var musicVolume : Float {
        get {
            if let musicVolume = NSUserDefaults.standardUserDefaults().objectForKey(MSSettingModelConstants.musicVolume) as? NSNumber {
                print("we have a musicVolume:\(musicVolume)")
                return musicVolume.floatValue
            }
            print("default music volume: 0.5")
            return 0.5
        }
        set (newMusicVolume) {
            NSUserDefaults.standardUserDefaults().setFloat(newMusicVolume, forKey: MSSettingModelConstants.musicVolume)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var soundEffectsVolume : Float {
        get {
            if let effectsVolume = NSUserDefaults.standardUserDefaults().floatForKey(MSSettingModelConstants.effectsVolume) as Float? {
                print("we have a effectsVolume:\(effectsVolume)")
                return effectsVolume
            }
            print("default effects volume: 0.5")
            return 0.5
        }
        set (newEffectsVolume) {
            NSUserDefaults.standardUserDefaults().setFloat(newEffectsVolume, forKey: MSSettingModelConstants.effectsVolume)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var gridSize : Int {
        get {
            if let gridSize = NSUserDefaults.standardUserDefaults().integerForKey(MSSettingModelConstants.gridSize) as Int? {
                print("we have a gridSize:\(gridSize)")
                return gridSize
            }
            print("default grid size: 6")
            return 6
        }
        set (newInt) {
            NSUserDefaults.standardUserDefaults().setInteger(newInt, forKey: MSSettingModelConstants.gridSize)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    var mineCount : Int {
        get {
            if let mineCount = NSUserDefaults.standardUserDefaults().integerForKey(MSSettingModelConstants.mineCount) as Int? {
                print("we have a mineCount:\(mineCount)")
                return mineCount
            }
            print("default mine count: 10")
            return 10
        }
        set (newInt) {
            NSUserDefaults.standardUserDefaults().setInteger(newInt, forKey: MSSettingModelConstants.mineCount)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    init () {
    }
    
}
