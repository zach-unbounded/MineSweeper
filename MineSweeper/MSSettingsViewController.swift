//
//  MSSettingsViewController.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import UIKit

class MSSettingsViewController: UIViewController {
    
    @IBOutlet weak var musicVolumeSlider: UISlider!
    @IBOutlet weak var soundEffectsVolumeSlider: UISlider!
    @IBOutlet weak var gridSizeSelectorSegCtrl: UISegmentedControl!
    @IBOutlet weak var numbeOfMinesSlider: UISlider!
    
    @IBAction func musicVolumeChanged(sender: AnyObject) {
        MSSoundSystem.sharedInstance.setVolumeForBackgroundMusic(musicVolumeSlider.value)
    }
    
    let gridSizeLookupTable = [4,6,8,16,32,64,128,256,512]
    
    var model:MSSettingModel = MSSettingModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // TODO: setup the segment control so that smaller devices can only play smaller grid sizes and larger devices must player bigger grids
        
        // use current settings model to setup the view
        self.setupView();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        musicVolumeSlider.value = MSSettingModel.sharedInstance.musicVolume
        soundEffectsVolumeSlider.value = MSSettingModel.sharedInstance.soundEffectsVolume
        
        if let actualGridSizeIndex = gridSizeLookupTable.indexOf( MSSettingModel.sharedInstance.gridSize) {
            gridSizeSelectorSegCtrl.selectedSegmentIndex = actualGridSizeIndex;
        }
        else {
            gridSizeSelectorSegCtrl.selectedSegmentIndex = 1;
        }
        musicVolumeSlider.value = MSSettingModel.sharedInstance.musicVolume
    }
    
    @IBAction func didSaveSettings(sender: AnyObject) {
        MSSettingModel.sharedInstance.musicVolume = musicVolumeSlider.value
        MSSettingModel.sharedInstance.soundEffectsVolume = soundEffectsVolumeSlider.value
        
        MSSettingModel.sharedInstance.gridSize = gridSizeLookupTable[gridSizeSelectorSegCtrl.selectedSegmentIndex]
        MSSettingModel.sharedInstance.musicVolume = musicVolumeSlider.value
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
