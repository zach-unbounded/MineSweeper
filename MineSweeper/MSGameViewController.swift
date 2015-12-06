//
//  MSGameView.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import UIKit


class MSGameViewController: UIViewController {
    
    @IBOutlet weak var gameGridCollectionView: UICollectionView!
    @IBOutlet weak var gridSettingsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    private let sectionInsets = UIEdgeInsets(top: 0.1, left: 0.1, bottom: 0.1, right: 0.1)
    
    private let reuseIdentifier = "gameCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MSGameViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    // MARK : CollectionView datasource

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print("returning one")
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("returning gridSize : \(MSSettingModel.sharedInstance.gridSize * MSSettingModel.sharedInstance.gridSize)")
        return MSSettingModel.sharedInstance.gridSize * MSSettingModel.sharedInstance.gridSize;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = UIColor.blackColor()
        }
        else {
            cell.backgroundColor = UIColor.lightGrayColor()
        }
        
        return cell
    }
    
    // MARK : CollectionView Delegate
    
}

extension MSGameViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // get current screen width divide by grid size
        let dimention : Int = Int(gameGridCollectionView.bounds.size.width) / MSSettingModel.sharedInstance.gridSize;
        print("cell dimentions: \(dimention)x\(dimention)");
        return CGSize(width: dimention, height: dimention)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        print("UIEdgeInsets requested!")
            return sectionInsets
    }
}