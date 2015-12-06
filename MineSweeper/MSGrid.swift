//
//  MSGrid.swift
//  MineSweeper
//
//  Created by Zachary Burgess on 01/12/2015.
//  Copyright © 2015 V.Rei Ltd. All rights reserved.
//

import Foundation

class MSGrid {
    private var grid : [[MSGridCell]]
    
    init(){
        grid = [[MSGridCell]](count: 0, repeatedValue: [MSGridCell](count: 0, repeatedValue: MSGridCell()))
    }
    
    convenience init(dimentions : Int) {
        self.init()
        self.setDimentions(dimentions)
    }
    
    func setDimentions(dimentions : Int) {
        grid = [[MSGridCell]](count: dimentions, repeatedValue: [MSGridCell](count: dimentions, repeatedValue: MSGridCell()))
    }
    
    func updateCell(indexPath : NSIndexPath, state:GridCellState) -> Bool {
        if grid.count > indexPath.top {
            if grid[indexPath.top].count > indexPath.down {
                let cell = grid[indexPath.top][indexPath.down]
                cell.state = state
                return true
            }
        }
        return false
    }
    
    func cellAtIndex(indexPath : NSIndexPath) -> MSGridCell? {
        return grid[indexPath.top][indexPath.down]
    }
    
    func cellsSeroundingIndex(indexPath : NSIndexPath) -> [MSGridCell] {
        let cells = [MSGridCell]()
        
        
        
        return cells
    }
}

extension NSIndexPath {
    
    public convenience init(top: Int, inDown down: Int) {
        self.init()
        var indexPath = self.indexPathByAddingIndex(top)
        indexPath = indexPath.indexPathByAddingIndex(down)
    }
    
    public var top: Int {
        get {
            return self.indexAtPosition(0)
        }
    }
    
    public var down: Int {
        get {
            return self.indexAtPosition(1)
        }
    }
}