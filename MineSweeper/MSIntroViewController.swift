//
//  ViewController.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import UIKit

class MSIntroViewController: UIViewController {
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // boot up sound engine
        MSSoundSystem.sharedInstance.startBackgroundMusic(MSSettingModel.sharedInstance.musicVolume)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

