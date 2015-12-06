//
//  MSSettingsViewController.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import UIKit

class MSSettingsViewController: UIViewController, KeyboardAccessoryViewDelegate, KeyboardAccessoryViewDataSouce {
    
    @IBOutlet weak var musicVolumeSlider: UISlider!
    @IBOutlet weak var soundEffectsVolumeSlider: UISlider!
    @IBOutlet weak var gridSizeSelector: UITextField!
    @IBOutlet weak var numbeOfMinesSlider: UISlider!
    @IBOutlet weak var numbeOfMinesLabel: UILabel!
    @IBOutlet var buttonBar : MSKeyboardAccessoryView!
    
    let gridSizeLookupTable = [4,6,8,16,32,64,128,256,512]
    var selectedGridSize = 4
    var mineCount = 4
    @IBOutlet weak var mineCountLabel: UILabel!
    
    var model:MSSettingModel = MSSettingModel();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Added this view to the storyboard so that its visible, however we need it removed from the main view so that it can be used by the keyboard as an accessory
        self.buttonBar.removeFromSuperview()
        
        // TODO: setup the segment control so that smaller devices can only play smaller grid sizes and larger devices must player bigger grids
        self.buttonBar.delegate = self;
        self.buttonBar.datasource = self;
        // use current settings model to setup the view
        self.setupView();
    }
    
    func updateGridTextView() {
        self.gridSizeSelector.text = "\(self.selectedGridSize) x \(self.selectedGridSize)"
    }
    
    func updateMineCountLabel() {
        self.mineCountLabel.text = "Mines (\(self.mineCount)) : "
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        musicVolumeSlider.value = MSSettingModel.sharedInstance.musicVolume
        soundEffectsVolumeSlider.value = MSSettingModel.sharedInstance.soundEffectsVolume
        musicVolumeSlider.value = MSSettingModel.sharedInstance.musicVolume
        
        self.mineCount = MSSettingModel.sharedInstance.mineCount
        self.numbeOfMinesSlider.value = Float(self.mineCount)
        self.updateMineCountLabel()
        
        // add the picker view
        let pickerView : UIPickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        self.selectedGridSize = MSSettingModel.sharedInstance.gridSize
        self.gridSizeSelector.inputView = pickerView
        self.gridSizeSelector.inputAccessoryView = self.buttonBar;
        self.updateGridTextView()
    }
    
    @IBAction func musicVolumeChanged(sender: AnyObject) {
        MSSoundSystem.sharedInstance.setVolumeForBackgroundMusic(musicVolumeSlider.value)
    }
    
    @IBAction func effectsVolumeChanged(sender: AnyObject) {
        //MSSoundSystem.sharedInstance.setVolumeForEffects(musicVolumeSlider.value)
    }
    
    @IBAction func numberOfMinesChanged(sender: AnyObject) {
        if let currentMineCount : Int = Int(self.numbeOfMinesSlider.value) {
            self.mineCount = currentMineCount
            self.updateMineCountLabel()
        }
    }
    
    
    @IBAction func didSaveSettings(sender: AnyObject) {
        MSSettingModel.sharedInstance.musicVolume = musicVolumeSlider.value
        MSSettingModel.sharedInstance.soundEffectsVolume = soundEffectsVolumeSlider.value
        
        MSSettingModel.sharedInstance.gridSize = selectedGridSize
        MSSettingModel.sharedInstance.musicVolume = musicVolumeSlider.value
        MSSettingModel.sharedInstance.mineCount = self.mineCount
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func keyboardAccessoryViewButtonTitle(keyboardAccessory: MSKeyboardAccessoryView, buttonIndex: KeyboardAccessoryViewButtonIndex) -> String? {
        switch buttonIndex {
        case .RightButtonIndex :
            return "Select"
        default:
            return nil
        }
    }
    
    func keyboardAccessoryViewPressedButton(keyboardAccessory: MSKeyboardAccessoryView, buttonIndex: KeyboardAccessoryViewButtonIndex) {
        switch buttonIndex {
        case .LeftButtonIndex :
            self.gridSizeSelector.resignFirstResponder()
        default :
            break
        }
    }
}

extension MSSettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gridSizeLookupTable.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.gridSizeLookupTable[row]) x \(self.gridSizeLookupTable[row])"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedGridSize = self.gridSizeLookupTable[row]
        self.updateGridTextView()
    }
}
