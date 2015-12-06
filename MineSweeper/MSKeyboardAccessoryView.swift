//
//  MSKeyboardAccessoryView.swift
//  MineSweeper
//
//  Created by Zachary BURGESS on 06/12/2015.
//  Copyright © 2015 RBS. All rights reserved.
//

import Foundation
import UIKit

public enum KeyboardAccessoryViewButtonIndex {
    case LeftButtonIndex, RightButtonIndex
};

public protocol KeyboardAccessoryViewDelegate {
    func keyboardAccessoryViewPressedButton(keyboardAccessory : MSKeyboardAccessoryView, buttonIndex : KeyboardAccessoryViewButtonIndex)
    
}

public protocol KeyboardAccessoryViewDataSouce {
    func keyboardAccessoryViewButtonTitle(keyboardAccessory : MSKeyboardAccessoryView, buttonIndex : KeyboardAccessoryViewButtonIndex) -> String?
    
}

public class MSKeyboardAccessoryView : UIView {
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var delegate : KeyboardAccessoryViewDelegate?
    var datasource : KeyboardAccessoryViewDataSouce? {
        didSet {
            self.rightButton.setTitle(self.datasource!.keyboardAccessoryViewButtonTitle(self, buttonIndex :.RightButtonIndex), forState:.Normal)
            
            self.leftButton.setTitle(self.datasource!.keyboardAccessoryViewButtonTitle(self, buttonIndex :.LeftButtonIndex), forState:.Normal)
            
            if self.rightButton != nil && self.rightButton.titleLabel != nil && self.rightButton.titleLabel!.text != nil {
                if (self.rightButton != nil && self.rightButton.titleLabel!.text!.characters.count > 0) {
                    self.rightButton.alpha = 1.0;
                }
            }
            if self.leftButton != nil && self.leftButton.titleLabel != nil && self.leftButton.titleLabel!.text != nil {
                if (self.leftButton != nil && self.leftButton.titleLabel!.text!.characters.count > 0) {
                    self.leftButton.alpha = 1.0;
                }
            }
        }
    }
    
    // MARK : Initialisers
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setButtonEnabled(false, buttonIndex: .RightButtonIndex)
    }
    
    // MARK : Public methods
    
    public func setButtonEnabled(enabled : Bool, buttonIndex : KeyboardAccessoryViewButtonIndex) {
        switch buttonIndex {
        case .LeftButtonIndex :
            if (self.leftButton != nil) {
                self.leftButton.enabled = enabled
            }
            
        case .RightButtonIndex :
            if (self.rightButton != nil) {
                self.rightButton.enabled = enabled
            }
        }
    }
    
    public func isButtonEnabled(buttonIndex : KeyboardAccessoryViewButtonIndex) ->Bool {
        switch buttonIndex {
        case .LeftButtonIndex :
            if (self.leftButton != nil) {
                return self.leftButton.enabled
            }
            else {
                return false
            }
            
        case .RightButtonIndex :
            if (self.rightButton != nil) {
                return self.rightButton.enabled
            }
            else {
                return false
            }
        }
    }
    
    
    @IBAction func didTapLeftButton(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.keyboardAccessoryViewPressedButton(self, buttonIndex: .LeftButtonIndex)
        }
        self.leftButton.selected = false;
        self.leftButton.highlighted = false;
    }
    
    @IBAction func didTapRightButton(sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.keyboardAccessoryViewPressedButton(self, buttonIndex: .LeftButtonIndex)
        }
        self.rightButton.selected = false;
        self.rightButton.highlighted = false;
    }
    
    // MARK : Private Methods
    
    private func setup() {// shadow stuff
        self.layer.shadowColor = UIColor.blackColor().CGColor;
        self.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        self.layer.shadowRadius = 2.5
        
        // buttons start hidden then reveil if title from data source is not nil
        self.rightButton.alpha = 0.0
        self.leftButton.alpha = 0.0
        
        self.leftButton.highlighted = false
        self.rightButton.highlighted = false
        
        self.leftButton.accessibilityIdentifier = "leftButton"
        self.rightButton.accessibilityIdentifier = "rightButton"
        
        self.leftButton.enabled = false
        self.rightButton.enabled = false
    }
}
