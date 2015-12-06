//
//  MSGridCellModel.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import Foundation

enum GridCellState {
    case GridCellStateEmpty
    case GridCellStateCovered
    case GridCellStateMined
    case GridCellStateFlagged
}

class MSGridCell : Hashable {
    var uuid: String;
    
    var state : GridCellState;
    
    var hashValue: Int {
        return self.uuid.hashValue
    }
    
    init () {
        uuid = NSUUID().UUIDString
        state = .GridCellStateCovered
    }
}

func == (lhs: MSGridCell, rhs: MSGridCell) -> Bool {
    return  lhs.state == rhs.state && lhs.uuid == rhs.uuid
}
